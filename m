Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABCA80C6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjLKKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjLKKg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:36:58 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546ED2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:37:04 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67ab19339b4so29808156d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702291023; x=1702895823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xZZSpag6K2BrrxUB+HXexjy0tvgok7Hn3gQdazxamw=;
        b=QBIfDKvLL5uUNay6AxyqufLxo9IouB1IBJb06qeRDlxx6PfaEOlVQnVnaG4ZHQLZSA
         2JeeAvRN3w8FZ0Xc/8L8fqtsiCpUNRtyusCfYeV8FTBOevAuI5O7c/e6IhFp+IOKDTtH
         u9KTF7iRydG0e7Xd6caQIQkMoze+rH/2E3M/Dny3LWnh0nxZzc5Tuo/kE2YkbVIPgi6m
         wZVNZtAeBZ5I6e/E//O7SHk/wjKRgwRfefrA36RRCej1YbMUQd7rj5OiY1YRXz084fbY
         G947zyxToqma0CuyasEq6o3dI/WLGwgpVGllUKXfNmHCeAd+SCQWU2GJc5yKTUwJqeu8
         wyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291023; x=1702895823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xZZSpag6K2BrrxUB+HXexjy0tvgok7Hn3gQdazxamw=;
        b=k69yzxv78WvXsw+sTvJ3bk+y+xAaqgKB2rVbmIKpGjB87dIvNdV5p6LVVKiItjJMW0
         dfg71fVOrvmplFDng5+tCpnzw3xxWEkU+eUueiUhRRWtdq8k30ReCMWuz5msr42nFszp
         qYzYu/RpU7n+8o80IvHxd/6VDkjW50N007Tnugc/A260Rp0wpA1hzE7DiElaruF2fJOS
         gsz/ZGCH6IZrhiXuMQDMjIyq0T2VTCNkNLItYM+hQzpm2GrUilOUsk+PCeYj3FT/h7TU
         txQpgEtZQhbuUOANp3MPullw+rNT/4w4VBsC9CnVu0DKqulG8NdGmrTHxoKN9wreS9mh
         AoLQ==
X-Gm-Message-State: AOJu0YyijHnzvf/ZHikzq7bfJ9BWqE6irazylWDhRLp7IA7WNF5gjT9p
        BWqmTU3PWLfsXhapF2wfViiBcFgb4u+cjazQ5p4r9g==
X-Google-Smtp-Source: AGHT+IG2hreF5WUvCkeK9/1PTdi6XuXHKd5OzzWIV9TutEPZLQcFZOECLixwnYp9kHhdQ4NW9Hm2iZIo6eRfJV7Vqu8=
X-Received: by 2002:a05:6214:5cc:b0:67a:97a4:1f73 with SMTP id
 t12-20020a05621405cc00b0067a97a41f73mr5565614qvz.40.1702291023543; Mon, 11
 Dec 2023 02:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-26-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-26-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 11:36:27 +0100
Message-ID: <CAG_fn=W7EQph__sbiBvNdaaSFG3-vweA396Oa81QoXAE8+b9yA@mail.gmail.com>
Subject: Re: [PATCH v2 25/33] s390/cpacf: Unpoison the results of cpacf_trng()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Prevent KMSAN from complaining about buffers filled by cpacf_trng()
> being uninitialized.
>
> Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
