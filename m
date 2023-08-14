Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B16077BA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjHNNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjHNNdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:33:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1D3212D;
        Mon, 14 Aug 2023 06:33:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC1A41063;
        Mon, 14 Aug 2023 06:33:48 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.65.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD4CD3F64C;
        Mon, 14 Aug 2023 06:33:03 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:32:48 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        jstultz@google.com, qyousef@google.com, lukasz.luba@arm.com
Subject: Re: [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
Message-ID: <ZNotAI1T+hKfzJWV@e126311.manchester.arm.com>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306122549.236561-1-douglas.raillard@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:25:49PM +0000, Douglas RAILLARD wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Fix the nid_t field so that its size is correctly reported in the text
> format embedded in trace.dat files. As it stands, it is reported as
> being of size 4:
> 
>         field:nid_t nid[3];     offset:24;      size:4; signed:0;
> 
> Instead of 12:
> 
>         field:nid_t nid[3];     offset:24;      size:12;        signed:0;
> 
> This also fixes the reported offset of subsequent fields so that they
> match with the actual struct layout.
> 
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  include/trace/events/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 31d994e6b4ca..8d053838d6cf 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -512,7 +512,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(ino_t,	ino)
> -		__field(nid_t,	nid[3])
> +		__array(nid_t,	nid, 3)
>  		__field(int,	depth)
>  		__field(int,	err)
>  	),
> -- 
> 2.25.1

Hi,

Just wanted to flag that I noticed this breaks Perfetto tracing on
Android, at least as of Android 13. I'm not sure if it's been fixed in newer
versions. Looks like the version of Perfetto in Android 13 is expecting
the previous (ie broken) field format to be there and its entire ftrace
collector fails as a result:

E/perfetto( 3532): ranslation_table.cc:133 Failed to infer ftrace field type for "f2fs_truncate_partial_nodes.nid" (type:"nid_t nid[3]" size:12 signed:0) (errno: 2, No such file or directory)
I/perfetto( 3640):            probes.cc:65 Hard resetting ftrace state.

For my own purposes I just reverted these two:
* 0b04d4c0542e8573a837b1d81b94209e48723b25 (f2fs: Fix f2fs_truncate_partial_nodes ftrace event)
* f82e7ca019dfad3b006fd3b772f7ac569672db55 (tracing: Error if a trace event has an array for a __field()

and now it works fine so not the biggest deal but this should probably
be addressed, I imagine more likely on the Perfetto side.
