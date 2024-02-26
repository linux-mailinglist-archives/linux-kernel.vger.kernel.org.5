Return-Path: <linux-kernel+bounces-82115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B8867F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B801F26253
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7512EBF3;
	Mon, 26 Feb 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixYUk7FY"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063CF12CD99
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970540; cv=none; b=IzBbMN9eYC1cJqfZBMm2Uz9m6oBmyyLw3Mzd0Zugc9IjL2b6ouuIEEqToBKkazVbrHHmmD4QS6m/ZELMvYh0Xm+m/jEHcznD/LNWu7JC/4pG/8fmsVq79tE5f9YmCo5BmuSMg5pLLRBFEPDcsYMbXhE/fR4loLpXXQ8RtuxG3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970540; c=relaxed/simple;
	bh=hdr4ZbnEXODijpEDky8ouwQnYopzGBrjVTpACJDh7fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aj1NJEZiPqB2JL7GR1psI5krshPVBXwvNlB8igeC+R/vchidHLkyDsPbYWvQRSW7CruIbVFKNY9X7bjr1uBmYgKG1L8q/ROnpfYHJsxOP9LCN/aHmemrzlCTj7JaDFMZj7yQalsoIrEZxkcv16Wp5Z6ZGdzEiV7Jv2n009FHrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ixYUk7FY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6900e209df4so7478786d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708970538; x=1709575338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdr4ZbnEXODijpEDky8ouwQnYopzGBrjVTpACJDh7fM=;
        b=ixYUk7FYdZ8OiCgCX0e2XUUDTyiArkdseQyeLTPB7MDhh5bsZbdtCWgDuUzcP6Kjz1
         NJf4SzQw9RkqZ8KyfCGVxYjR0bBQISqTsGNqz3LWqCBy5O08WtpXg/1M58SS9iwGQZsi
         yhN2w1Up31IeN7joAOKefE19LSBrcCtd3AEfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708970538; x=1709575338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdr4ZbnEXODijpEDky8ouwQnYopzGBrjVTpACJDh7fM=;
        b=OwtNVAPFhA0Yo8u5H8gMyp9I0zDFBmsQaRZeqxlbl4VFGG+E9VxSGiA9+NISuQgXEA
         RjIXvuPRrvcqJ+lQofEi0ETpWKBtPSjQZIpiT9n0IyggkPnODaW5exLSLdNF2rNcLh3c
         QAuDl2YHM5m8/nNOLoPGR7hNI3Kfz/ydC3xWm5ZpPTGX7iN62SHWcyLP+lUrBeUBHTWF
         bw3nuCcK4OWdXIT+lsvtobAEALa6aa5jW+b3fg2pDPfRmApwX39+vilKsUUzcBKoCZYG
         i4b5Uv5DDYjHbBlpsY6sDBIfvjDTvrL/+oUn0JJH19oGUs5DJVyi4teUg5ZrkxGnZHJL
         PaGw==
X-Forwarded-Encrypted: i=1; AJvYcCVvFfxz3uPQZHu4g1Z2nPKMTcJtJn/5SrqW5gTAmgJDPFk+i0zXATTkERJrpM3OoCIagW/FOrdvMoKrjTJ6oFhslmJ2gGOOLWUeCF1V
X-Gm-Message-State: AOJu0Yw9mnzaefdBU8L3HqJCz54TB1/hDpmAd8ZQuHeM+df1qHYilXTa
	BtwgZ/FiCdVH2XZhrcvP9Qv+cJybIdFsLfV/rkp1kpGjHjJkSUcPYyg6DbAZ1FzZcj+Iqq2Wwfo
	vjBYkCeMVQHko9Bu8nz4W5dFfxwH85zSQ/k2Z
X-Google-Smtp-Source: AGHT+IEV9P9k8lXpLuRloExNgbCIESKZHzR9wiRiMPX2/PLjCV6iI5UxsSI6ALNh2KaP1n8qdbRYs7YdyqwimjOC9Ck=
X-Received: by 2002:ad4:5962:0:b0:68f:ff45:8793 with SMTP id
 eq2-20020ad45962000000b0068fff458793mr6601047qvb.25.1708970538049; Mon, 26
 Feb 2024 10:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com> <20240223010328.2826774-4-jthies@google.com>
In-Reply-To: <20240223010328.2826774-4-jthies@google.com>
From: Prashant Malani <pmalani@chromium.org>
Date: Mon, 26 Feb 2024 10:02:06 -0800
Message-ID: <CACeCKacHYxdvdzaRxRMREeXWfbunhSy-3q+sSKHbJ+u9XXQukQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:04=E2=80=AFPM Jameson Thies <jthies@google.com> w=
rote:
>
> Register SOP and SOP' Discover Identity responses with the USB Type-C
> Connector Class as partner and cable identities, respectively. Discover
> Identity responses are requested from the PPM using the GET_PD_MESSAGE
> UCSI command.
>
> Signed-off-by: Jameson Thies <jthies@google.com>
I've reviewed this internally already [1], and it looks good to me:

Reviewed-by: Prashant Malani <pmalani@chromium.org>

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/5260256

