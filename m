Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800CE77A477
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 03:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHMBBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 21:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHMBBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 21:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDF81706;
        Sat, 12 Aug 2023 18:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B5A861C43;
        Sun, 13 Aug 2023 01:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E45EC433C7;
        Sun, 13 Aug 2023 01:01:42 +0000 (UTC)
Date:   Sat, 12 Aug 2023 21:01:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheao Li <me@manjusaka.me>
Cc:     edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230812210140.117da558@rorschach.local.home>
In-Reply-To: <20230812205905.016106c0@rorschach.local.home>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
        <20230812201249.62237-1-me@manjusaka.me>
        <20230812205905.016106c0@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 20:59:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Aug 2023 20:12:50 +0000
> Zheao Li <me@manjusaka.me> wrote:
> 
> > +TRACE_EVENT(tcp_ca_event,
> > +
> > +	TP_PROTO(struct sock *sk, const u8 ca_event),
> > +
> > +	TP_ARGS(sk, ca_event),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(const void *, skaddr)
> > +		__field(__u16, sport)
> > +		__field(__u16, dport)
> > +		__field(__u16, family)
> > +		__array(__u8, saddr, 4)
> > +		__array(__u8, daddr, 4)
> > +		__array(__u8, saddr_v6, 16)
> > +		__array(__u8, daddr_v6, 16)
> > +		__field(__u8, ca_event)  
> 
> Please DO NOT LISTEN TO CHECKPATCH!
> 
> The above looks horrendous! Put it back to:
> 
> > +		__field(	const void *,	skaddr			)
> > +		__field(	__u16,		sport			)
> > +		__field(	__u16,		dport			)
> > +		__field(	__u16,		family			)
> > +		__array(	__u8,		saddr,		4	)
> > +		__array(	__u8,		daddr,		4	)
> > +		__array(	__u8,		saddr_v6,	16	)
> > +		__array(	__u8,		daddr_v6,	16	)
> > +		__field(	__u8,		ca_event		)  
> 
> See how much better it looks I can see fields this way.
> 
> The "checkpatch" way is a condensed mess.
> 

The below patch makes checkpatch not complain about some of this. But
there's still more to do.

-- Steve

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a52..24df11e8c861 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -73,6 +73,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
+my $trace_macros = "__array|__dynamic_array|__field|__string|EMe?";
 
 sub help {
 	my ($exitcode) = @_;
@@ -5387,7 +5388,8 @@ sub process {
 
 # check spacing on parentheses
 		if ($line =~ /\(\s/ && $line !~ /\(\s*(?:\\)?$/ &&
-		    $line !~ /for\s*\(\s+;/) {
+		    $line !~ /for\s*\(\s+;/ &&
+		    $line !~ m/$trace_macros/) {
 			if (ERROR("SPACING",
 				  "space prohibited after that open parenthesis '('\n" . $herecurr) &&
 			    $fix) {
@@ -5397,7 +5399,8 @@ sub process {
 		}
 		if ($line =~ /(\s+)\)/ && $line !~ /^.\s*\)/ &&
 		    $line !~ /for\s*\(.*;\s+\)/ &&
-		    $line !~ /:\s+\)/) {
+		    $line !~ /:\s+\)/ &&
+		    $line !~ m/$trace_macros/) {
 			if (ERROR("SPACING",
 				  "space prohibited before that close parenthesis ')'\n" . $herecurr) &&
 			    $fix) {
@@ -5906,6 +5909,7 @@ sub process {
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
 			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
 			    $dstat !~ /^do\s*{/ &&					# do {...
+			    $dstat !~ /^EMe?\s*1u/ &&					# EM( and EMe( are commonly used with TRACE_DEFINE_ENUM
 			    $dstat !~ /^\(\{/ &&						# ({...
 			    $ctx !~ /^.\s*#\s*define\s+TRACE_(?:SYSTEM|INCLUDE_FILE|INCLUDE_PATH)\b/)
 			{
@@ -6017,7 +6021,8 @@ sub process {
 					WARN("DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON",
 					     "do {} while (0) macros should not be semicolon terminated\n" . "$herectx");
 				}
-			} elsif ($dstat =~ /^\+\s*#\s*define\s+$Ident.*;\s*$/) {
+			} elsif ($dstat =~ /^\+\s*#\s*define\s+$Ident.*;\s*$/ &&
+				 $dstat !~ /TRACE_DEFINE_ENUM\(/) {
 				$ctx =~ s/\n*$//;
 				my $cnt = statement_rawlines($ctx);
 				my $herectx = get_stat_here($linenr, $cnt, $here);
