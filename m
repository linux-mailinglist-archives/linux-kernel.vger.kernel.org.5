Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04534766083
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjG1AJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjG1AJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2EA3;
        Thu, 27 Jul 2023 17:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FEF561F8A;
        Fri, 28 Jul 2023 00:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B95AC433C8;
        Fri, 28 Jul 2023 00:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690502965;
        bh=rzqoblIEWlM3hHtTZyUEn246YIy25ju6jJgTmQzgdPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/drBZeifHa2O/gu0oH4MqjYC9auzCZhY2nUsKo8BlkKXNFQXUeP5EMSAPwL16rlJ
         Gr/U+t/1qcE44mvyh/bDb8Q6n0eGIS6raK7Wntc6jmnvdWH/SxVVJiA7N72lBE7MoR
         sMKmCsasb/48A6QskzGPBd6ADunRZMADiIQPaIEBD6vHYTAJTkzvgjl5FML+5CeH4o
         chZ59Tl3R3dHdMQca4Z9uiDlgwhmQ2KaZGywtv2sByBXYGQzu5RUT95FPmE0kGpEhU
         rxNY2ECEbK2xT2UUCxMSZp47P1jd38vOtzZZT4c01fwhRlOiFMqR/Uaeorfdg0TRKD
         0r3/Oe6uDVM3Q==
Date:   Fri, 28 Jul 2023 09:09:20 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230728090920.82a2088da3406847a8bc3d48@kernel.org>
In-Reply-To: <CAADnVQJjZt=e-nSOmrxGJa59DLEQfaJupyx3RfwQhqXx8Vghmw@mail.gmail.com>
References: <169037639315.607919.2613476171148037242.stgit@devnote2>
        <169037642351.607919.10234149030120807556.stgit@devnote2>
        <CAADnVQJjZt=e-nSOmrxGJa59DLEQfaJupyx3RfwQhqXx8Vghmw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 08:39:02 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Jul 26, 2023 at 6:00 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Add btf_find_struct_member() API to search a member of a given data structure
> > or union from the member's name.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  Changes in v3:
> >   - Remove simple input check.
> >   - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
> >   - Move the code next to btf_get_func_param().
> >   - Use for_each_member() macro instead of for-loop.
> >   - Use btf_type_skip_modifiers() instead of btf_type_by_id().
> > ---
> >  include/linux/btf.h |    3 +++
> >  kernel/bpf/btf.c    |   35 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 20e3a07eef8f..4b10d57ceee0 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const char *func_name,
> >                                            struct btf **btf_p);
> >  const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> >                                            s32 *nr);
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +                                               const struct btf_type *type,
> > +                                               const char *member_name);
> >
> >  #define for_each_member(i, struct_type, member)                        \
> >         for (i = 0, member = btf_type_member(struct_type);      \
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index f7b25c615269..5258870030fc 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -958,6 +958,41 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
> >                 return NULL;
> >  }
> >
> > +/*
> > + * Find a member of data structure/union by name and return it.
> > + * Return NULL if not found, or -EINVAL if parameter is invalid.
> > + */
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +                                               const struct btf_type *type,
> > +                                               const char *member_name)
> > +{
> > +       const struct btf_member *member, *ret;
> > +       const char *name;
> > +       int i;
> > +
> > +       if (!btf_type_is_struct(type))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       for_each_member(i, type, member) {
> > +               if (!member->name_off) {
> > +                       /* unnamed member: dig deeper */
> > +                       type = btf_type_skip_modifiers(btf, member->type, NULL);
> > +                       if (type) {
> > +                               ret = btf_find_struct_member(btf, type,
> > +                                                            member_name);
> 
> Unbounded recursion in the kernel? Ouch. That might cause issues.
> Please convert it to a loop. It doesn't have to be recursive.

Oh, I thought non-name union will not be nested so much. But yes, if there is
any issue on BTF itself, it is not safe.
Let me make it fixed stacked loop.

Thank you!

> 
> > +                               if (!IS_ERR_OR_NULL(ret))
> > +                                       return ret;
> > +                       }
> > +               } else {
> > +                       name = btf_name_by_offset(btf, member->name_off);
> > +                       if (name && !strcmp(member_name, name))
> > +                               return member;
> > +               }
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  #define BTF_SHOW_MAX_ITER      10
> >
> >  #define BTF_KIND_BIT(kind)     (1ULL << kind)
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
