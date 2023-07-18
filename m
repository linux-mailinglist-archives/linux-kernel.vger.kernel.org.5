Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD575712C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGRBCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGRBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D02E2;
        Mon, 17 Jul 2023 18:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363B36134B;
        Tue, 18 Jul 2023 01:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BBFC433C8;
        Tue, 18 Jul 2023 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689642170;
        bh=X2pd9jY6qyeLWCbJd7xCd01gpGFD2mp11sP4+x3BZGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m9qljdco6PnTkw9XeV+F/Ypq+kMkntbgVo3WSlNkGo7xfXdBsG/vLRPOYQrsObi5d
         8SyKU5dYA7C7Jqiq0L3iRhOtN5oWgLPlsBkJWt/T6BRXCP5OhilVPSjZG6qwiIsrtm
         fwiJ5FuNsq4tKhpNf6V6O4owwPrH0EbRvKQ8E51DzGpAnB7Dv+1viRwmGcJv1pXjm2
         JUqCUc3kHuXuO8GNtxLUzFRBosGcz1TxKwQLnzzLBQaE+u9+FpW0ab9BWMBRXxg2E2
         LAVWfKBztNJ42Asd7lM0Q6QljtwFEd8oLWYS3tq8NyPKHY9CYBcWph33qXoTRnGsLE
         dkCwVRjf03+MA==
Date:   Tue, 18 Jul 2023 10:02:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230718100246.87e2ad49bfd8fa056b3db2ef@kernel.org>
In-Reply-To: <20230717195129.14759151@gandalf.local.home>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <168960741686.34107.6330273416064011062.stgit@devnote2>
        <20230717143914.5399a8e4@gandalf.local.home>
        <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
        <20230717195129.14759151@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 19:51:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Jul 2023 08:46:34 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > > + * Get function parameter with the number of parameters.
> > > > + * This can return NULL if the function has no parameters.  
> > > 
> > >   " It can return EINVAL if this function's parameters are NULL."  
> > 
> > No, as you can see the code, if btf_type_vlen(func_proto) returns 0 (means
> > the function proto type has no parameters), btf_get_func_param() returns
> > NULL. This is important point because user needs to use IS_ERR_OR_NULL(ret)
> > instead of IS_ERR(ret).
> 
> I didn't mean to replace what you had, I meant you left that part out. In
> other words, you have to check for IS_ERR_OR_NULL(ret), not just "!ret".

Ah, got it! Let me update it.

Thank you!

> 
> -- Steve
> 
> > >   
> > > > + */
> > > > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > > > +{
> > > > +	if (!func_proto || !nr)
> > > > +		return ERR_PTR(-EINVAL);
> > > > +


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
