Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740747570AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGQXvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGQXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563CB91;
        Mon, 17 Jul 2023 16:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE680611E4;
        Mon, 17 Jul 2023 23:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753CAC433C7;
        Mon, 17 Jul 2023 23:51:31 +0000 (UTC)
Date:   Mon, 17 Jul 2023 19:51:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-ID: <20230717195129.14759151@gandalf.local.home>
In-Reply-To: <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <168960741686.34107.6330273416064011062.stgit@devnote2>
        <20230717143914.5399a8e4@gandalf.local.home>
        <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 08:46:34 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > + * Get function parameter with the number of parameters.
> > > + * This can return NULL if the function has no parameters.  
> > 
> >   " It can return EINVAL if this function's parameters are NULL."  
> 
> No, as you can see the code, if btf_type_vlen(func_proto) returns 0 (means
> the function proto type has no parameters), btf_get_func_param() returns
> NULL. This is important point because user needs to use IS_ERR_OR_NULL(ret)
> instead of IS_ERR(ret).

I didn't mean to replace what you had, I meant you left that part out. In
other words, you have to check for IS_ERR_OR_NULL(ret), not just "!ret".

-- Steve

> >   
> > > + */
> > > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > > +{
> > > +	if (!func_proto || !nr)
> > > +		return ERR_PTR(-EINVAL);
> > > +
