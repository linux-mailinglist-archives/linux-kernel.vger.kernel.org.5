Return-Path: <linux-kernel+bounces-37902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B132883B76E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63B81C23B05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8FF6FBE;
	Thu, 25 Jan 2024 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rO3SxlF0"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E416FAE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151377; cv=none; b=RCE8oHs/E9JNEcgGh+7r9y/VFklF6m6JnKsoIDEFY/LlOXDp26tKWSAgFNget4ID/FrRDKZnklr2lI0iKK/UR8Z1zyboTT+rvR+HfOZ3Z/lJkvw2TzkCjZgT+CwHrI6LsxsWph6/1tMJ5UoTKu5GgUkGQNXgIKaOy1w2NJyDlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151377; c=relaxed/simple;
	bh=+GZSLD+cOcJ3jym7MpaTStTGyWAozRe2QNP8DcXFwCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4zZUotiSFwQvDj007oXlY0T1HMNmSVC9L+yB7oNuzF5yttNhbabKipAh2sKtA29bq5oeMgSp4dQnnvDbM/LUqcOTzl59apxPnKX9iVnWRnWxglbW2sqH5grxrWPIlO+rgLQINBaoorJZ8o9gpJ/PCwOcuJvUDddYSG5vS+wU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rO3SxlF0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42a5512e357so100441cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706151375; x=1706756175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8J2xC5JlvCmC/CfXhkb6Bg3Qtna5eStZ/uU4hB8NFA=;
        b=rO3SxlF09inrkPWBRpAE6aENACLhwe1hIOltNUjw2zMvr/FGeb9VVLUKLut2w3wLbh
         +w+FouPbvT/FdJemuqymN0x6ofLd1neUrGhgBYWMkvL94zADVgaXPXToFEaDXzdnhr64
         QDTXPnBQrfvDP2eg51akaMc0ne5wdRWbwe5NMw0SpaAZf+k7Mvm9ay6FMU1yDjScxTQC
         GHkhm9A6lKOmU0+boM3tk/DDooCwEvB6zZkYe0TbZX5hLxcelG7sup7siWHXh0968sce
         E8hds3hHkEMJSC653RantaYX7mKSmYkMOhD7w/JX4tGnMoIk3FzY736Bxly3a8xDQvYk
         wEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706151375; x=1706756175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8J2xC5JlvCmC/CfXhkb6Bg3Qtna5eStZ/uU4hB8NFA=;
        b=Zz8Hqp53p9JKGm0K5yTDr8hBhqkep/j7KCgCEV40ojHeOtqKGtIN9xwZrrNfGH27yO
         mmeC2EIszGKIku05LpmXBCwMQsFn4873DngbYf/gYOj/MQI2YCtZykBmLbv8frhsXlh5
         RpvPzPc/xFL4sevYynO0lmaOR2YydZB4ovCtbol+BN8sPC45+IHSQHwMKYROY4bmW7oo
         z22GZ9E2f1Y65ttZ677HTyXZhbyf51/RjB7N/5MAoF677FIWR6LRzYwKJuWmI6Eh84Bq
         3ELodXjlqqX6KpFUmNpCyAgJZ61dyTRi0/wvae5ZaMAKlex2A81Hep5+X7ETxLFkSqtN
         49Ww==
X-Gm-Message-State: AOJu0YzxrID7L86fWYuWDfldN7uSHa+hGGly6OjjdtY5kkALENmxAmCz
	maF1xPJ7TYjScN85UAwnktBvTjVd0ToClsfcasRjcnsK+PDz6SIUQKdiNog8pcYrXma1yfdpk7c
	kH1gTxeGBpVTrwkhyqCxzOANjCS6xitTzg/sl
X-Google-Smtp-Source: AGHT+IFpyK74c0wNi73ADMp89NyRWVgblVfRg3K82OEoRvccsLpgtWBl6Mnu4t6ZnRv5MtA3n6lONxqZHM2nWu2dwPU=
X-Received: by 2002:a05:622a:1f0c:b0:429:ca07:1c8 with SMTP id
 ca12-20020a05622a1f0c00b00429ca0701c8mr104408qtb.23.1706151374876; Wed, 24
 Jan 2024 18:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124084636.1415652-1-xu.yang_2@nxp.com>
In-Reply-To: <20240124084636.1415652-1-xu.yang_2@nxp.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 24 Jan 2024 18:55:38 -0800
Message-ID: <CAGETcx9h8gA8EenyR0B0OPa23uw_8dk-Kft8c8+F3StfpyMtaw@mail.gmail.com>
Subject: Re: [PATCH] driver core: improve cycle detection on fwnode graph
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:40=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Currently, cycle detection on fwnode graph is still defective.
> Such as fwnode link A.EP->B is not marked as cycle in below case:
>
>                  +-----+
>                  |     |
>  +-----+         |  +--|
>  |     |<-----------|EP|
>  |--+  |         |  +--|
>  |EP|----------->|     |
>  |--+  |         |  B  |
>  |     |         +-----+
>  |  A  |            ^
>  +-----+   +-----+  |
>     |      |     |  |
>     +----->|  C  |--+
>            |     |
>            +-----+
>
> 1. Node C is populated as device C. But nodes A and B are still not
>    populated. When do cycle detection with device C, no cycle is found.
> 2. Node B is populated as device B. When do cycle detection with device
>    B, it found a link cycle B.EP->A->C->B. Then, fwnode link B.EP->A,
>    A->C and C->B are marked as cycle. The fwnode link C->B is converted
>    to device link too.
> 3. Node A is populated as device A. When do cycle detection with device
>    A, it find A->C is marked as cycle and convert it to device link. It
>    also find B.EP->A is marked as cycle but will not convert it to device
>    link since node B.EP is not a device.

Your example doesn't sound correct (I'l explain further down) and it
is vague. Need a couple of clarifications first.

1. What is the ---> representing? Is it references in DT or fwnode
links? Which end of the arrow is the consumer? The tail or the pointy
end? I typically use the format consumer --> supplier.

2. You say "link" sometimes but it's not clear if you mean fwnode
links or device links. So please be explicit about it.

3. Your statement "Such as fwnode link A.EP->B is not marked as cycle"
doesn't sound correct. When remote-endpoint properties are parsed, the
fwnode is created from the device node with compatible property to the
destination. So A.EP ----> B can't exist if I assume the consumer -->
supplier format.

4. Has this actually caused an issue? If so, what is it? And give me
an example in an upstream DT.

Btw, I definitely don't anticipate ACKing this patch because the cycle
detection code shouldn't be having property specific logic. It's not
even DT specific in this place. If there is an issue and it needs
fixing, it should be where the fwnode links are created. But then
again I'm not sure what the actual symptom we are trying to solve is.


-Saravana

>
> Finally, fwnode link C->B and A->C is removed, B.EP->A is only marked as
> cycle and A.EP->B is neither been marked as cycle nor removed.
>
> For fwnode graph, the endpoint node can only be a supplier of other node
> and the endpoint node will never be populated as device. Therefore, when
> creating device link to supplier for fwnode graph, we need to relax cycle
> with the real node rather endpoint node.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14d46af40f9a..278ded6cd3ce 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2217,6 +2217,9 @@ static void __fw_devlink_link_to_suppliers(struct d=
evice *dev,
>                 int ret;
>                 struct fwnode_handle *sup =3D link->supplier;
>
> +               if (fwnode_graph_is_endpoint(sup))
> +                       sup =3D fwnode_graph_get_port_parent(sup);
> +
>                 ret =3D fw_devlink_create_devlink(dev, sup, link);
>                 if (!own_link || ret =3D=3D -EAGAIN)
>                         continue;
> --
> 2.34.1
>

