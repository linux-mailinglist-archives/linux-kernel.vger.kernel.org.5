Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9B7549FD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGOQH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:07:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136A2D51;
        Sat, 15 Jul 2023 09:07:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso1742126a12.1;
        Sat, 15 Jul 2023 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689437271; x=1692029271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sUtg26Gpo7j59R3RzfFBIeeNFosdNr/GBdLzVrzsz0=;
        b=RI2qvc7R3BbEv4hjXfJcGXAxJBeXfZ3AFoRuQA0Lt/eDCcBqmfcJ7OV+OBLQc8f65u
         XmLHjep66FoGIL7XR77VZ4f2xjL3MnODsxnOd7YJhwgbHoWxJbr44fxpiMBAorReItNY
         v4O/XIHS1o4bfnI5jdQPnecZ1458/DpIXav7n+wQgMsVKlILwhOlC/b6Ra0psdJTbfdF
         VeAymfqJ6Prw9XYbX7Y68Yj8k3BU+NOL42hPFNB57A96qEHTWorYRrlk3+frW4kl4Hf9
         DtNm2tN9G+S+XmkC3R6JV7cuEXNA80bgHSnm1r6JyK5rWuTRnUxdIIOKCcpatZxXC18o
         CC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689437271; x=1692029271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sUtg26Gpo7j59R3RzfFBIeeNFosdNr/GBdLzVrzsz0=;
        b=SYwMFHFZzAeyaabPP25wQ3OdMbl6pN1L+B4IPiUIsFLAaqAn4RXxcQBjVwfNteyYM9
         orV/j9pgQM/IByYM1hHwXrOVjGEiCT0o8jedSqGayQJraFtohhYOfXX7Gb6YnXZYNJ5Y
         CH2Lki3TyWgmODEvnSQnySClWXm0/EozTGg7UzrUB+Y0BiB1dlGCs/QmCUu/tlLjbpam
         /EhY4bP3Op8bZreS0Vza0iaqdernhJgmA9cUTYPxWpBWDnVcodFCoHYNZsqSoLkj+QIw
         J7xHVem/K4rrHE5Qvclh0BvC2tq4DJaz8zUEJh0WKhF0Wk1avNcFW2Mh3gu931BHbAmi
         xdig==
X-Gm-Message-State: ABy/qLZjHMq2AIodzekQ5e+sHxOw+lPqFgtNiza/Yg6GG15nAKHbVTNx
        4RvrNGG/j6TnG1+nbiNqkcWd21hp8J96XbmbACk=
X-Google-Smtp-Source: APBJJlHoO4n7r2ZSCBszhTAskN4fYnH459vF4qab03Yzozh+bPryh3YCt0mq5XU5p835MPCfzKD2rSjduW8810PK4Qo=
X-Received: by 2002:a17:902:efd5:b0:1bb:25bd:d09c with SMTP id
 ja21-20020a170902efd500b001bb25bdd09cmr968719plb.1.1689437271455; Sat, 15 Jul
 2023 09:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230311180630.4011201-1-zyytlz.wz@163.com> <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org> <20230712115633.GB10768@google.com>
In-Reply-To: <20230712115633.GB10768@google.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 16 Jul 2023 00:07:39 +0800
Message-ID: <CAJedcCzRVSW7_R5WN0v3KdUQGdLEA88T3V2YUKmQO+A+uCQU8Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
To:     Lee Jones <lee@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, s.shtylyov@omp.ru,
        Zheng Wang <zyytlz.wz@163.com>, davem@davemloft.net,
        linyunsheng@huawei.com, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my late reply. I'll see what I can do later.

Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=B8=89 19:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 10 Jul 2023, Jakub Kicinski wrote:
>
> > On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > > For better or worse, it looks like this issue was assigned a CVE.
> >
> > Ugh, what a joke.
>
> I think that's putting it politely. :)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
