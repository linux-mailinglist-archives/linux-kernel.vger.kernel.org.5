Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADF37AB074
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjIVLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjIVLTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A6FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695381503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GiW7xPy++se+q6i0olY89hLKZg8oY2P2U269iGcbHgc=;
        b=BEGoQLJOwGFJEqrSzmFPNwGUyqB0uTCE7frGmONpl5zYpzdTTQACGy47ruKmQThr71jkOd
        LraBedyUdVZmzbQzb6XpGCsUhuh7Y5f8gv9D+LqTy3O2UGGQRQY2S2TP0lYlUIMVQFUo/0
        nGTQdalaFJsfs+LSEy5vouV4NsnALEM=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-cCfcGaWXOoadAYWiBTylqA-1; Fri, 22 Sep 2023 07:18:22 -0400
X-MC-Unique: cCfcGaWXOoadAYWiBTylqA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-45265939145so859888137.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381501; x=1695986301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiW7xPy++se+q6i0olY89hLKZg8oY2P2U269iGcbHgc=;
        b=coPITD9yXXLchtJCoOWmnsAlOUbHJLUD+whAqleKv3JRkhMkwZRJxb7uECLTMxbcze
         t3h8+Nkmx2B4JMOhY1oPbJABtotCvAqBlInHciXOZAuVfCH9+3pCAu5lrr/8GV30V7rO
         fsxWnUVdqmlzEiD7v1YaMJlrRkUHql/Sx4r5DUyr109lSF3G4urFI5F1YZN4Bftadx99
         Q7/SMDQCcAQ+sDiMISgK0cp3Kcm+qBxxVIricdIXOuOvyIlOaaYr33/4HrR76xiigqk5
         pPbb+xsY+eC/1GLg6is4I6UXt6lHAZvaezOQgOmK8yiuf2OletiPBMkzXGg3YXJ07Fmr
         Mp7g==
X-Gm-Message-State: AOJu0YxI7dc5XRfVwblcs/mfueupxgDrMOL3h9FfAbcY+NujV2akYah+
        O+NTi+afwHm8ixf82MehugdBQnxBAgFthsliywSkPxekGFwtYLpJ4k+U+flO3LptAeG1hh7ovMF
        /+9R4RIuORdfrzMvaqg2Z4e1Nl5XAT24GcL2zyXei
X-Received: by 2002:a05:6102:24d:b0:44d:626b:94da with SMTP id a13-20020a056102024d00b0044d626b94damr7897842vsq.32.1695381501551;
        Fri, 22 Sep 2023 04:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECd8EeaqAfIOTvpZu2YbNzYrM6BT+Exh7ByejQWuxuzmBp6EbQZln1Ql6a1cLmCSI0wvZNFC0ZMF1t7Of9NDg=
X-Received: by 2002:a05:6102:24d:b0:44d:626b:94da with SMTP id
 a13-20020a056102024d00b0044d626b94damr7897831vsq.32.1695381501312; Fri, 22
 Sep 2023 04:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230921114940.957141-1-pbonzini@redhat.com> <169537583818.27769.18320521458994415527.tip-bot2@tip-bot2>
 <ZQ1rwSJsO7A4HR8O@gmail.com>
In-Reply-To: <ZQ1rwSJsO7A4HR8O@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 22 Sep 2023 13:18:09 +0200
Message-ID: <CABgObfbiO5Jm-S_1TVi-NdO4GxMsJeagaEHYEFBJ_6ABFdhicg@mail.gmail.com>
Subject: Re: [tip: x86/cpu] x86/cpu: Clear SVM feature if disabled by BIOS
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:26=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
> It's a bit sad that we are duplicating identical code.
> We are doing it in other cases as well: for example nearby_node() is
> duplicated between arch/x86/kernel/cpu/amd.c and
> arch/x86/kernel/cpu/hygon.c too.

It is sad, and yeah I looked at nearby_node() to see if that was neverthele=
ss
expected.

AMD and Hygon pretend that they are different, and use different families
for what is effectively the same processor, and that's silly. In fact back =
in
2018 (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1741155.=
html)
I complained that if AMD and Hygon are organizing the family numbers so
that there's never going to be a conflict, it makes no sense to have a
separate vendor at all.

Yes it's not a lot of code but sooner or later some change will be applied
only to amd.c, because honestly who even thinks of Hygon...

Paolo

