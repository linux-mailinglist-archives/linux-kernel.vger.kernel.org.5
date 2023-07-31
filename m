Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBD769F61
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjGaRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjGaRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D2D1BE9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690824062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NfShcrH5vNeU09yfaTlylFugR/gu1+MgjXGX+9Q5ac=;
        b=LMoAJ+pM9MEEPOrRC9JdUH/4a+sIWt++2GkINyIZ7fvj634xw9jjMMPRXLKYUh8j11edKA
        LS5s79y8GjdsO6yZzQsIxoRdY/149y0hZhtFYp6p87t4kFFh8zSl73ipoLJjlyXNnvEG7I
        F5OGbuec1Ndqd6s6ey8gCPCbhou5EIo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-c5ESEDuFNx2tC9oZaZy6qQ-1; Mon, 31 Jul 2023 13:21:01 -0400
X-MC-Unique: c5ESEDuFNx2tC9oZaZy6qQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-585fb08172bso28821647b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690824060; x=1691428860;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NfShcrH5vNeU09yfaTlylFugR/gu1+MgjXGX+9Q5ac=;
        b=NCcVMELqT5eTGZyb+2gw7sPhbQ63vePEnxoA5nwrfi32l8VYvy89ZfWVX3FmDnzxXn
         i1U302vLxwcBnYOe+CBOrbCczobAafreU40j/i3SO6uDxBMgyxIZ55hFIdsjsvcYKDEb
         OEOodtpwRQ8PsuW7vJ1Xb4ac65QhKPlcCFlqr1pGwTFCS/amcBgO8JGbX7f1PMQiJSck
         i1iieOi4mKfGy+cPd/CIA1UFRavzCiDwh+KTSYunEOiG6q7Cni2Q81zTW7BSXB/Qv66o
         IueYm13kmxgO+4tnImgGy2PtTVGdTqinPPLErGYRQo/LlBRG+NDOu+EY7Z3H3jBirTku
         Qt5g==
X-Gm-Message-State: ABy/qLYaBSMpTCf3HrbsXkWp3sZWnvHWbvpdK8eJSaAE8+8zbkPCRWzB
        D3Elw/wY0S5D32YY2qvldy+niNSPbgUd1Totxf7nwNdYA+t96FP9lXYSVwrzzmBCRSAUn4oSpus
        IOYMkFqEWx9seHUd3mBiGlVz5
X-Received: by 2002:a81:c24f:0:b0:583:4304:75a4 with SMTP id t15-20020a81c24f000000b00583430475a4mr10696713ywg.29.1690824060502;
        Mon, 31 Jul 2023 10:21:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFbVJszIfUaYg4Uc4+wm7XQPO4r+bpFj464rdlreCyyKuJOaZIruagzYqntofPsjWen070/Bg==
X-Received: by 2002:a81:c24f:0:b0:583:4304:75a4 with SMTP id t15-20020a81c24f000000b00583430475a4mr10696647ywg.29.1690824059920;
        Mon, 31 Jul 2023 10:20:59 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id 10-20020ac8208a000000b00401f7f23ab6sm3744764qtd.85.2023.07.31.10.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:20:59 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 06/20] tracing/filters: Optimise scalar vs
 cpumask filtering when the user mask is a single CPU
In-Reply-To: <b7cf996a-f443-402c-8e13-c5f25a964184@kadam.mountain>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-7-vschneid@redhat.com>
 <20230729155547.35719a1f@rorschach.local.home>
 <04f20e58-6b24-4f44-94e2-0d12324a30e4@kadam.mountain>
 <20230731115453.395d20c6@gandalf.local.home>
 <b7cf996a-f443-402c-8e13-c5f25a964184@kadam.mountain>
Date:   Mon, 31 Jul 2023 18:20:49 +0100
Message-ID: <xhsmhy1iwq9ou.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/23 19:03, Dan Carpenter wrote:
> On Mon, Jul 31, 2023 at 11:54:53AM -0400, Steven Rostedt wrote:
>> On Mon, 31 Jul 2023 15:07:52 +0300
>> Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>
>> > On Sat, Jul 29, 2023 at 03:55:47PM -0400, Steven Rostedt wrote:
>> > > > @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void=
 *data,
>> > > >                                FILTER_PRED_FN_CPUMASK;
>> > > >                } else if (field->filter_type =3D=3D FILTER_CPU) {
>> > > >                        pred->fn_num =3D FILTER_PRED_FN_CPU_CPUMASK;
>> > > > +		} else if (single) {
>> > > > +			pred->op =3D pred->op =3D=3D OP_BAND ? OP_EQ : pred->op;
>> > >
>> > > Nit, the above can be written as:
>> > >
>> > >                  pred->op =3D pret->op !=3D OP_BAND ? : OP_EQ;
>> > >
>> >
>> > Heh.  Those are not equivalent.  The right way to write this is:
>>
>> You mean because of my typo?
>
> No, I hadn't seen the s/pred/pret/ typo.  Your code does:
>
>       if (pred->op !=3D OP_BAND)
>               pred->op =3D true;
>       else
>               pred->op OP_EQ;
>
> Realy we should probably trigger a static checker warning any time
> someone does a compare operations as part of a "x =3D comparison ?: bar;
> Years ago, someone asked me to do that with regards to error codes like:
>
>       return ret < 0 ?: -EINVAL;
>
> but I don't remember the results.
>

FWIW this is caught by GCC:

     error: the omitted middle operand in ?: will always be =E2=80=98true=
=E2=80=99, suggest explicit middle operand [-Werror=3Dparentheses]
     pred->op =3D pred->op !=3D OP_BAND ? : OP_EQ;


> regards,
> dan carpenter

