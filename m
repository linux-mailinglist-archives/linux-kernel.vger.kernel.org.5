Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C077C19D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHNUiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjHNUhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EA410F7;
        Mon, 14 Aug 2023 13:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D91761419;
        Mon, 14 Aug 2023 20:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D9AC433C8;
        Mon, 14 Aug 2023 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692045458;
        bh=p/3cegYidBuPQOysI3EfoMODZv58DITeMGmAbN5Lraw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9Gj4ubRIm3PLxL0kOHAMCQbhl5UCr73qpln3KKMYGI8BLRT42nJyC5CTPpHF4ndY
         YBIPHCeJjmV2NH0Q3B/m/UnVyIoottcNuILf10IYEJG4+zUfkHphzakSnVN8VdfUlM
         iSXTFMuoXVShf2rz3Vq8J2jZczWE3g/r4n9A5klaL+G5rDuLAEdJ5NffG20axDDyMD
         PUG67WZiX27Od1lPassZvtcavO5pQK9uxsL6hDMkQP/NyY8A6s6Wc71FT4hKfs2w34
         NjUqxAtygX/kWlTIAL5iqO4tdReb4cBWgwprtGdqwkylzH6CZZR3DhkE1kmALM2djG
         TaDUDVV2xUmHg==
Date:   Mon, 14 Aug 2023 13:37:36 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Douglas RAILLARD <douglas.raillard@arm.com>,
        Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        jstultz@google.com, qyousef@google.com, lukasz.luba@arm.com
Subject: Re: [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
Message-ID: <ZNqQkDm0YschY+WI@google.com>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
 <ZNotAI1T+hKfzJWV@e126311.manchester.arm.com>
 <ZNo8hoR2V3Zo14+l@e126311.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNo8hoR2V3Zo14+l@e126311.manchester.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, Kajetan Puchalski wrote:
> On Mon, Aug 14, 2023 at 02:32:53PM +0100, Kajetan Puchalski wrote:
> > On Mon, Mar 06, 2023 at 12:25:49PM +0000, Douglas RAILLARD wrote:
> > > From: Douglas Raillard <douglas.raillard@arm.com>
> > > 
> > > Fix the nid_t field so that its size is correctly reported in the text
> > > format embedded in trace.dat files. As it stands, it is reported as
> > > being of size 4:
> > > 
> > >         field:nid_t nid[3];     offset:24;      size:4; signed:0;
> > > 
> > > Instead of 12:
> > > 
> > >         field:nid_t nid[3];     offset:24;      size:12;        signed:0;
> > > 
> > > This also fixes the reported offset of subsequent fields so that they
> > > match with the actual struct layout.
> > > 
> > > 
> > > Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> > > ---
> > >  include/trace/events/f2fs.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > > index 31d994e6b4ca..8d053838d6cf 100644
> > > --- a/include/trace/events/f2fs.h
> > > +++ b/include/trace/events/f2fs.h
> > > @@ -512,7 +512,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
> > >  	TP_STRUCT__entry(
> > >  		__field(dev_t,	dev)
> > >  		__field(ino_t,	ino)
> > > -		__field(nid_t,	nid[3])
> > > +		__array(nid_t,	nid, 3)
> > >  		__field(int,	depth)
> > >  		__field(int,	err)
> > >  	),
> > > -- 
> > > 2.25.1
> > 
> > Hi,
> > 
> > Just wanted to flag that I noticed this breaks Perfetto tracing on
> > Android, at least as of Android 13. I'm not sure if it's been fixed in newer
> > versions. Looks like the version of Perfetto in Android 13 is expecting
> > the previous (ie broken) field format to be there and its entire ftrace
> > collector fails as a result:
> > 
> > E/perfetto( 3532): ranslation_table.cc:133 Failed to infer ftrace field type for "f2fs_truncate_partial_nodes.nid" (type:"nid_t nid[3]" size:12 signed:0) (errno: 2, No such file or directory)
> > I/perfetto( 3640):            probes.cc:65 Hard resetting ftrace state.
> > 
> > For my own purposes I just reverted these two:
> > * 0b04d4c0542e8573a837b1d81b94209e48723b25 (f2fs: Fix f2fs_truncate_partial_nodes ftrace event)
> > * f82e7ca019dfad3b006fd3b772f7ac569672db55 (tracing: Error if a trace event has an array for a __field()
> > 
> > and now it works fine so not the biggest deal but this should probably
> > be addressed, I imagine more likely on the Perfetto side.
> 
> Added context here, it is just caused by the parser implementation in Perfetto
> being pretty lacking:
> 
> https://github.com/google/perfetto/blob/c36c70c1d4a72eafdd257f7a63e55f49fbc3df3d/src/traced/probes/ftrace/proto_translation_table.cc#L255

Hi, I believe this was fixed by
https://android-review.git.corp.google.com/c/platform/external/perfetto/+/2587146
