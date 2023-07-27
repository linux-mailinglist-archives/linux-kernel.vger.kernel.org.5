Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19581764907
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjG0HmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjG0HmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747A59DA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690443289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/d1hElCRlKYILqamKbhScYXhcTsJFSt0ooe3i9EVAI=;
        b=e5knfw9uMq50UQ0QMsKT2BfVQQt3PAYNR/PpIhjXV9yA/h8IjNz1DIA+fcEuGsFgmsa8Iq
        GpvmFS0fcCbU43HZ40nc0E1yLgpNeJe1rrlYhsczC2tNRVaZtLvvjd+Te+w/u8V8bbJJYq
        BZo7NeU6f2qqDsS0jMeifapYG1xCXXA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-cNhoqxBkPsuWeS7mwyIYCg-1; Thu, 27 Jul 2023 03:34:46 -0400
X-MC-Unique: cNhoqxBkPsuWeS7mwyIYCg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d2b88325bso1911726d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443286; x=1691048086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/d1hElCRlKYILqamKbhScYXhcTsJFSt0ooe3i9EVAI=;
        b=llJDptGjRDTYmFAhCzEeziEwDaGT1yfphLcCTdZNG9UDQ15YXgxryenPGtFTfWd0Sp
         ycf/EA9eVgiNJ/jWmr2qU/JgzTkY2MoQH8qQkmlZAikWYQyFJ4DJonJfs/RR+oBpMSoj
         zHNH5EVAXvg8BZcKuf0O4s6lVZvHrbDOF3E2K6S1c/wzHTshoTVoNu0MGnUKjPMwzq6R
         +CMYgEELKbHFBk8w2ZBUQzRPlY/SWW7zuhGN3uQfIMSyCE/JYcPtQ4Evi6XOXXySAg+P
         LiPR5eaE3z0gg6LqWNJF9ib6Mp5TrShaVP41wGr0aKwvgyHA7/Ol9fyhS7rY/hA8+lPv
         Uh+Q==
X-Gm-Message-State: ABy/qLaVJ3Q0O8b/zBVBxvRxjV6ph398B3UyM+ZlHRb8w+uErxFOh1GB
        6b0zhtwN+9ONr9zSqR+dIkpsNDa4Mq6k5F0dfenLBVOP+ewmlLSD/v097SOoo54CvArwV9hpFO5
        jxmNXgk9tfSVMMJ1+bqKiCyR5
X-Received: by 2002:a05:6214:19e9:b0:63c:7427:e7e9 with SMTP id q9-20020a05621419e900b0063c7427e7e9mr4493703qvc.6.1690443285857;
        Thu, 27 Jul 2023 00:34:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGTrykDjpbg/R1Mtb6qfJcIecQ9pyF15SQ90DIo/BDc2dp4I1nqmkSehaimfPaY6ZdARx0Vcw==
X-Received: by 2002:a05:6214:19e9:b0:63c:7427:e7e9 with SMTP id q9-20020a05621419e900b0063c7427e7e9mr4493694qvc.6.1690443285622;
        Thu, 27 Jul 2023 00:34:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id e16-20020a0caa50000000b0063d3dbf77f8sm106914qvb.51.2023.07.27.00.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:34:45 -0700 (PDT)
Message-ID: <c4ca108f891718188ea2a9560324d23de2740565.camel@redhat.com>
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lin Ma <linma@zju.edu.cn>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, ast@kernel.org,
        martin.lau@kernel.org, yhs@fb.com, void@manifault.com,
        andrii@kernel.org, houtao1@huawei.com, inwardvessel@gmail.com,
        kuniyu@amazon.com, songliubraving@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date:   Thu, 27 Jul 2023 09:34:41 +0200
In-Reply-To: <20230725023330.422856-1-linma@zju.edu.cn>
References: <20230725023330.422856-1-linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 10:33 +0800, Lin Ma wrote:
> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
> does not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as a 4 byte integer.
>=20
> This patch adds an additional check when the nlattr is getting counted.
> This makes sure the latter nla_get_u32 can access the attributes with
> the correct length.
>=20
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

I guess this should go via the ebpf tree, right? Setting the delegate
accordingly.=20

Please correct me if I'm wrong.

Thanks!

/P

