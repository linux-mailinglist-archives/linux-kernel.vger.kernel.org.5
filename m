Return-Path: <linux-kernel+bounces-40617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138183E33D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97F0B213E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C98622F03;
	Fri, 26 Jan 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrPOJ0Qg"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880F22EEF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300361; cv=none; b=hknLbAhDQdiHDOYYlq5xXhqZOMi8THYo+bOqAE//Z7RBhYaRdxi6JcLuyd7YAOlMsVDB/qNefZCmuqpy94fmgvYJSOK11q+gn0pBPcwc8G6QyoarkSUSthl9a34DkMJ35bbA5c3j9uRSfo9sn8Go0tM+a1Hb2qGpNKZ/DGm1S5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300361; c=relaxed/simple;
	bh=AveOdH/2OoQNEsucWyIJ+OME7OtrwMk18a5xqllqfxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdIUgsWdrlfAE8BZNjljenGO96K2ZuPc5V06xTR/34k3veh+UcpCD7DcThram2vtE3vK7kFv3KubiYEVc0jZXDQWgykXBVg69qEWrBYroCjJIUELpi8XqMC/Yzw8APkSgBytFrjpbvK3WwiF7hCM7IkZ7mL/yDSiEMSEVlAprtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RrPOJ0Qg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783c012593cso51397285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706300359; x=1706905159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AveOdH/2OoQNEsucWyIJ+OME7OtrwMk18a5xqllqfxc=;
        b=RrPOJ0Qg2qZ0/GMv/akJWVSTbIeNvyMait0BMb0Nw3BpJ6TmAiUSsOMdDnMGJnuBJT
         AAzEzlcbfr1Fyl+IXXkKsdsSwTjb19ovu0X0F0tcbBTfELY/6aslkoTYhBCOWZ53tZsQ
         rxhEpmp1meVA5aJ7b5SmJAiyPn4uxRETjzfo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300359; x=1706905159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AveOdH/2OoQNEsucWyIJ+OME7OtrwMk18a5xqllqfxc=;
        b=SWmu4AYYogLzCVn1of3aLAQCPJmgoDKhaUJFE8169slyxBhwDc3WUNASK03Nhnx4Fi
         7D695nk8FF3Llt4Ywy/exoU/RcUBxXotP9/cwAfDfx2pzj6wtBRN093mBinomPxADlre
         Nbew/Rs1QpZiZ1tDBYXPzNPq1TKgI1sEnKk2Bus5lDjqbmUwTzrf3UTCLYD57f5YN/e+
         VjtqfV6zUWAM3te1KbkJz0isAYSnF1tJmVGw63lr5upjZu63qI2A0OaBTyFlxzL5NzXZ
         g6t28g7RTCLAqJ17tj0EJBmiodZNOOb59fCZFyYHMqinn4G5ivMPBqPsk8H+IZfsDOzm
         J38Q==
X-Gm-Message-State: AOJu0YyYORBhD3RVEX0SNyj6KdflTTeaL+81zEnh8+MCbvQaolFiMgC2
	horew8rYjJWLSajDenwhvfsk8rjsh+VkPgCuoCOPd0pnMGlVPqxMuLpJw6iaAn5IlGnCy/+5ye5
	mx6yxJvyOap6KOcnzpHG0drglPhY7aNDnILM6vU6PrUvPCTA=
X-Google-Smtp-Source: AGHT+IE6kufSJQsRyqNQemNAhb7CnZLNSDSuYgnGuGGQVgwdz3tGQ2/seVVUOU+NAbGqhSZQQooN96AW2K6r3nUs5tg=
X-Received: by 2002:a05:620a:3623:b0:781:b188:c7ec with SMTP id
 da35-20020a05620a362300b00781b188c7ecmr2083538qkb.74.1706300359078; Fri, 26
 Jan 2024 12:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126183930.1170845-1-abhishekpandit@chromium.org> <20240126103859.v3.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
In-Reply-To: <20240126103859.v3.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
From: Prashant Malani <pmalani@chromium.org>
Date: Fri, 26 Jan 2024 12:19:07 -0800
Message-ID: <CACeCKadGF2=LytNbit_uyHm8jQ72K+1s3NbO=n5tJNjdtBg9aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] usb: typec: ucsi: Update connector cap and status
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Fri, Jan 26, 2024 at 10:39=E2=80=AFAM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Update the data structures for ucsi_connector_capability and
> ucsi_connector_status to UCSIv3.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Same comment as Patch 2/3: Please collect review tags that you've
received on previous
versions, unless the patchset is significantly different (which it
isn't in this case).
Or, if you're choosing to drop the tags, please explain why in the changelo=
g.

Reviewed-by: Prashant Malani <pmalani@chromium.org>

