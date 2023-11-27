Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AB7FA19B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjK0NzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjK0Nyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A33A1BF1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA89C433CB;
        Mon, 27 Nov 2023 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093271;
        bh=x8+axdfJnWcUTrYe+z6TxMAlJf7WBymVwQzRmWFuviE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpc9evsTNarsDVwG4URGVbx2z9JD2xuyvsua8/jM3OgZTRRjECZeoefY/rz77RNH8
         tVkw8sFInsRrwrs6uIx4TohZExMunko97zDk3OXyb/DvUxGLQRu93OutVCak6vFsoa
         afSruwfshNiGdQSdoAY5WOCtrpInZob9S5FGS6Tc=
Date:   Mon, 27 Nov 2023 13:43:57 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kernfs: Convert from strlcpy() to strscpy()
Message-ID: <2023112751-cozy-dangle-3f5a@gregkh>
References: <20231116191718.work.246-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116191718.work.246-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:21:22AM -0800, Kees Cook wrote:
> Hi,
> 
> One of the last users of strlcpy() is kernfs, which has some complex
> calling hierarchies that needed to be carefully examined. This series
> refactors the strlcpy() calls into strscpy() calls, and bubbles up all
> changes in return value checking for callers.

Why not work instead to convert kernfs (and by proxy cgroups) to use the
"safe" string functions based on seq_file?  This should be a simpler
patch series to review, and implement on a per-function basis, and then
we would not have any string functions in kernfs anymore.

thanks,

greg k-h
