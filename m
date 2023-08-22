Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6789C784476
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjHVOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjHVOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5291;
        Tue, 22 Aug 2023 07:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2087F63513;
        Tue, 22 Aug 2023 14:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF417C433C7;
        Tue, 22 Aug 2023 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714993;
        bh=xQvQvrIK437NyWJbIp30mYO6bonnV3gFmgFZCl8XdxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lZZFW4BrrEmNyruPWDJmhRl42aB1WoBTJ7fhRqGJMCZfzxyj8jU4BFI19rFELpvRE
         9IPFwsEgiTxz6tJ9AOzMZ6i1JwxtQ8Ysr4OwqCRKRHSVUn05n3ZcA6A/bvYaiYbBA0
         CUkMp6nvC9coz54LQB70PdVx/dhuVVHRviwS4WDPDusKbgMb1nRgy+VxyBF9AiRnz0
         eE/XRuDf8T+r1tGAs/rKED7MVzYd7leB4BIkP8Nx8purnT2/NVp7ksjz4f6gpfpjTc
         OhZ1sU0n5+mgkPWwkeVTKgo5gJzEME+SSi0XdeovkanNjvRehfC3NrXY9xkREF3G1M
         BmdAk1zLNx9Hg==
Date:   Tue, 22 Aug 2023 23:36:29 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 3/9] tracing/probes: Add a function to search a
 member of a struct/union
Message-Id: <20230822233629.669b3a891a0155addf52f461@kernel.org>
In-Reply-To: <20230822093720.016c3554@rorschach.local.home>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
        <169137689818.271367.4200174950023036516.stgit@devnote2>
        <20230822093720.016c3554@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 09:37:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon,  7 Aug 2023 11:54:58 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > --- a/kernel/trace/trace_btf.c
> > +++ b/kernel/trace/trace_btf.c
> > @@ -50,3 +50,60 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
> >  		return NULL;
> >  }
> >  
> > +#define BTF_ANON_STACK_MAX	16
> > +
> > +/*
> > + * Find a member of data structure/union by name and return it.
> > + * Return NULL if not found, or -EINVAL if parameter is invalid.
> > + * If the member is an member of anonymous union/structure, the offset
> > + * of that anonymous union/structure is stored into @anon_offset. Caller
> > + * can calculate the correct offset from the root data structure by
> > + * adding anon_offset to the member's offset.
> > + */
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +						const struct btf_type *type,
> > +						const char *member_name,
> > +						u32 *anon_offset)
> > +{
> > +	struct {
> > +		u32 tid;
> > +		u32 offset;
> > +	} anon_stack[BTF_ANON_STACK_MAX];
> 
> Where is this called as the above is 128 bytes, which is a bit large
> for the stack. It may not be bad if it's not that generic of a
> function. But if the stack is getting tight, this could still be an
> issue.

OK, let me allocate an array then.

Thank you,

> 
> -- Steve
> 
> 
> > +	const struct btf_member *member;
> > +	u32 tid, cur_offset = 0;
> > +	const char *name;
> > +	int i, top = 0;
> > +
> > +retry:
> > +	if (!btf_type_is_struct(type))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	for_each_member(i, type, member) {
> > +		if (!member->name_off) {
> > +			/* Anonymous union/struct: push it for later use */
> > +			type = btf_type_skip_modifiers(btf, member->type, &tid);
> > +			if (type && top < BTF_ANON_STACK_MAX) {
> > +				anon_stack[top].tid = tid;
> > +				anon_stack[top++].offset =
> > +					cur_offset + member->offset;
> > +			}
> > +		} else {
> > +			name = btf_name_by_offset(btf, member->name_off);
> > +			if (name && !strcmp(member_name, name)) {
> > +				if (anon_offset)
> > +					*anon_offset = cur_offset;
> > +				return member;
> > +			}
> > +		}
> > +	}
> > +	if (top > 0) {
> > +		/* Pop from the anonymous stack and retry */
> > +		tid = anon_stack[--top].tid;
> > +		cur_offset = anon_stack[top].offset;
> > +		type = btf_type_by_id(btf, tid);
> > +		goto retry;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
