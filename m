Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82745784211
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjHVN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjHVN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:28:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB2CCE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:28:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc63ef9959so34935405ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692710893; x=1693315693;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxZ55EMzADqc7Vn1JWMMu+XroI194CgReOhVVFRwyr4=;
        b=uVTNjxuQapxQgN+qHR21wi3mfGqGBgPwPRt4NfTrcWF/w9Vw9P5fZG5OczQHnLkiAY
         3taqMUeS0pDH65ifPffXXesEAXofobDCJIH1+Xqv+7FxmosRDCGUvhLngavD/EaLxHEa
         aE958Meor1ib56vuhZxVUDe5BZwzLk+0A9F9KWo9lRYVbcvN4pI8emWlHzyIq2AU2/o6
         Sati9PmXbbPK/R1BJ3vAqFuKdtq8gYwU5/TJdybmmfU5LAdMTQR+ZMDg8JnnuZajvinY
         UmdlphClurdvKYji+hX20jdEjtWC8oVIQr3M7ZV6/5rgCTkKqNpXIMN4qoDte1IEC8cO
         J5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710893; x=1693315693;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxZ55EMzADqc7Vn1JWMMu+XroI194CgReOhVVFRwyr4=;
        b=PvNYVGNmmyzzNNsqFdFI5bpvIVnJG9nV+lcgg1F6UPXyAtpDmFcSZPXA6wM9j6kUT+
         Rw9+FJuDSTYmwrKyZ+ivGuZEXgo07pW/aNoNx07ggW5nmojdxfLxXaEMo+UI07iOKyIX
         93fw6oO046Ruc1iGlZcu7F/2EohLKzvAX0GXvcyyCORr+xROig1jcRmQRfWLqIQNfssx
         0kkrm7fsGwv5EDzd2mF6N4XJtDtIv0X3dGAdIiPrPaJBvnVzzk8aQql4aIKPkNMu1jsH
         ozZc3DMH+L8JyIuuUiDnkz2LTZuEXxEsuMuGB1UHtUibKrglBfPKBHFbLyldoF6baY1H
         1zbA==
X-Gm-Message-State: AOJu0YwN5+cW1x6Eb9V1GW0TYeTX8NFhDIdzAjbvMwmoS63ZjHEvQCCi
        JwdTvlcNBDUNzECDXbSDK9Yg1Q==
X-Google-Smtp-Source: AGHT+IG2dVgySB9lhtQiE7d0yi+85lxJuvrESHnNKppl7eTgOceEkjxu4uBVFUbq+mRe/1NiVMwlhw==
X-Received: by 2002:a17:902:e88e:b0:1bc:48dc:d881 with SMTP id w14-20020a170902e88e00b001bc48dcd881mr13438928plg.8.1692710892285;
        Tue, 22 Aug 2023 06:28:12 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ce8100b001b801044466sm9083672plg.114.2023.08.22.06.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2023 06:28:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] block: fix unexpected split in bio_discard_limit
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <CAFj5m9+sm55FJAoM5iYtM=4y6VA7QwqD9bPqS7_uauwKqBvpNQ@mail.gmail.com>
Date:   Tue, 22 Aug 2023 21:27:57 +0800
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6EFB969-309C-4A9B-AAE2-FFB93A0BB6E0@smartx.com>
References: <20230817075509.1438569-1-fengli@smartx.com>
 <CAFj5m9+sm55FJAoM5iYtM=4y6VA7QwqD9bPqS7_uauwKqBvpNQ@mail.gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B48=E6=9C=8822=E6=97=A5 21:07=EF=BC=8CMing Lei =
<ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Aug 17, 2023 at 3:42=E2=80=AFPM Li Feng <fengli@smartx.com> =
wrote:
>>=20
>> bio_discard_limit() enforces discard boundaries within the range of =
32-bit
>> unsigned integers, resulting in unexpected discard cut boundaries.
>=20
> Any bio size can't be bigger than UINT_MAX, see bio definition.
>=20
>>=20
>> For example, max discard size =3D 1MiB, discard_granularity =3D 512B, =
then the
>> discard lengths sent in the range [0,4G) are 1MiB, 1MiB... =
(1MiB-512).
>> The next discard offset from 4G is [4G-512, 4G-512+1MiB).
>> The discard of the 4G offset boundary does not comply with the =
optimal 1MiB
>> size.
>=20
> As mentioned, max bio size is 4GB, so there shouldn't be such issue.
>=20
> Thanks,
>=20
Got it, many thanks.

