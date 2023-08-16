Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3F77E48D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjHPPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343940AbjHPPCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422DB10FF;
        Wed, 16 Aug 2023 08:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB2946247A;
        Wed, 16 Aug 2023 15:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8FCC433C7;
        Wed, 16 Aug 2023 15:02:03 +0000 (UTC)
Date:   Wed, 16 Aug 2023 11:02:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Manjusaka <me@manjusaka.me>
Cc:     Joe Perches <joe@perches.com>, edumazet@google.com,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230816110206.13980573@gandalf.local.home>
In-Reply-To: <8b0f2d2b-c5a0-4654-9cc0-78873260a881@manjusaka.me>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
        <20230812201249.62237-1-me@manjusaka.me>
        <20230812205905.016106c0@rorschach.local.home>
        <20230812210140.117da558@rorschach.local.home>
        <20230812210450.53464a78@rorschach.local.home>
        <6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
        <20230812215327.1dbd30f3@rorschach.local.home>
        <a587dac9e02cfde669743fd54ab41a3c6014c5e9.camel@perches.com>
        <8b0f2d2b-c5a0-4654-9cc0-78873260a881@manjusaka.me>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 14:09:06 +0800
Manjusaka <me@manjusaka.me> wrote:

> > +# trace include files use a completely different grammar
> > +		next if ($realfile =~ m{(?:include/trace/events/|/trace\.h$/)});
> > +
> >  # check multi-line statement indentation matches previous line
> >  		if ($perl_version_ok &&
> >  		    $prevline =~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declare\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=\s*$Ident\s*)\(.*(\&\&|\|\||,)\s*$/) {
> > 
> > 
> >   
> 
> Actually, I'm not sure this is the checkpatch style issue or my code style issue.
> 
> Seems wired.

The TRACE_EVENT() macro has its own style. I need to document it, and
perhaps one day get checkpatch to understand it as well.

The TRACE_EVENT() typically looks like:


TRACE_EVENT(name,

	TP_PROTO(int arg1, struct foo *arg2, struct bar *arg3),

	TP_ARGS(arg1, arg2, arg3),

	TP_STRUCT__entry(
		__field(	int,		field1				)
		__array(	char,		mystring,	MYSTRLEN	)
		__string(	filename,	arg3->name			)
	),

	TP_fast_assign(
		__entry->field1 = arg1;
		memcpy(__entry->mystring, arg2->string);
		__assign_str(filename, arg3->name);
	),

	TP_printk("field1=%d mystring=%s filename=%s",
		__entry->field1, __entry->mystring, __get_str(filename))
);

The TP_STRUCT__entry() should be considered more of a "struct" layout than
a macro layout, and that's where checkpatch gets confused. The spacing
makes it much easier to see the fields and their types.

-- Steve
