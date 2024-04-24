Return-Path: <linux-kernel+bounces-156121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFE28AFE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBF31F23361
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8351171C;
	Wed, 24 Apr 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ei2NYRy2"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192CCA7D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924388; cv=none; b=UbP08tlubE5s26HmMOTDaZ/+oVUL7yI7PhRiXUCxyi9yV81+vEi2Urz2ZaN8Tf8KCBLs42Jkc3qILd1YVQf+51Qixki5w4QeMraxvkReNk9WIyOAInECWuZb5enZJpObw0TpUvKlDPcMv3aw5IGrJyMOLKFraM6SZoLfDS+ylcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924388; c=relaxed/simple;
	bh=ggqkpIJRRlUV6tAg88gjXJlRfrPJhi1RKOyLAZkKTE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irW1JClYS7RaH77Uw8Gbvv6+Y+xAndW/1voZxBvrWRZS3wwN5XcwjkMui2fDtYG+vuGa9oHl+uZ74DIo3leY9VvrSs83riq/5EuulUwhYC3qj1KJsc1SXmK97nkEQnjPCMcnNlA5JydHx9gWwm5AT5XGZuTsYm4M1SxRKcymVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ei2NYRy2; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de55e876597so1038044276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713924386; x=1714529186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VmXPwLmorMky3vFkXFEX7LkOC9EFvM8+1foS9yBPWI=;
        b=ei2NYRy2JYoPm+h8mKmll4edS1BhePitiK2WMIz+hLdlWgSNX0GFkT6yyzDyIIfEpo
         bII2+MKjfYekjcBNl0bmUG6GuYOJiOVLGU7EJoqoTEMNLNiZ4XNndsuc3+Ls6kO2+S2g
         Mflg4IMM1AZUXALKo3DZmTQsgz5UcOddKaY6gyZO3JyLAA10WIEN4dDOu9QZdUd914Tp
         f3LKUafcg7VS0eQC2FJ2lQsjlJdVXUlhP4TocL0jOLmwzOVXo0WYKv+uIidAeu1gbVLE
         AJFYIzL4NV1cjVyA6A4dZH21lI2Hej+mspYCMsOaBHaZBLrhyatwLZrtXTibB4yQuX0c
         vFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713924386; x=1714529186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VmXPwLmorMky3vFkXFEX7LkOC9EFvM8+1foS9yBPWI=;
        b=rXgvjqPDihI61cWEScsGncuoIs8yuZLTBOidy+t9vhVKPbY4+hOgGXeotg9pABFo0M
         cKdk6k/38VbhK9FGoTpjdKSV356uwbc9i+P5GE5MLDjcICIRgpx0GPvQe+K8VS8GxA/X
         OWVL7Yt+nAEQ/UFWXJMDAS9h8wD8Hj1I+lTnteXih0BPDCwTSrDe+tlU4AeyFjH0bI5D
         6QAMYDXyxLbeGALWqEIummwMcnFRYwGADT+s6DwMecQr9VyQ5weCv3SkMZFJwBp4p/Nx
         95kFZQ4hQuEfXu00JLNCJ4gQtKyXXGM44kUIuB8QPP844Na28ZDyuP8uteHkgHlif6rn
         iQqg==
X-Forwarded-Encrypted: i=1; AJvYcCWZkqdQbwWCumVDskf7jzfkHO3/qQQJ4WJvOCI0pL4d1F8ncG8HSJ4z2nXq52MxqWkl4YBLhaCeZ0fmfIPthrUBUM+6wBEopyi25wVA
X-Gm-Message-State: AOJu0Yx4EAdjWMNu7i2tqj4B6ZkhsCob3zWPosq2rQJJ3FTs6YxM9/sd
	tqRrqHT+Oc+B11joOgfcIhKXqhLqpkoMnzPmo+cv95lb58WhF7IYoX65SAlIcBfMHfVc1k6e6Z7
	iUTzU+vlDo4q2UpIXZU16oK2qlNDRyJ3FJFFEWw==
X-Google-Smtp-Source: AGHT+IEhyHQTOiRrOU18xVsOck1+aEKCBM/7FJTW0SWFltJ3m3W6GG8zqUGem9WcfD/aL4IVh4bbEmCIrWfgpSt8XeM=
X-Received: by 2002:a25:820a:0:b0:de5:5693:4e90 with SMTP id
 q10-20020a25820a000000b00de556934e90mr1495408ybk.40.1713924385958; Tue, 23
 Apr 2024 19:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424014821.4154159-1-jthies@google.com> <20240424014821.4154159-2-jthies@google.com>
In-Reply-To: <20240424014821.4154159-2-jthies@google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 05:06:14 +0300
Message-ID: <CAA8EJpq_DujhwoJ87Cg4gZ4LNdPu4i93EQ0VeKrCJPkeDj9ThQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 04:48, Jameson Thies <jthies@google.com> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> ucsi_register_altmode checks IS_ERR on returned pointer and treats
> NULL as valid. This results in a null deref when
> trace_ucsi_register_altmode is called. Return an error from
> ucsi_register_displayport when it is not supported and register the
> altmode with typec_port_register_altmode.
>
> Reviewed-by: Jameson Thies <jthies@google.com>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Changes in V2:
> - Checks for error response from ucsi_register_displayport when
> registering DisplayPort alternate mode.
>
>  drivers/usb/typec/ucsi/ucsi.c | 3 +++
>  drivers/usb/typec/ucsi/ucsi.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cb52e7b0a2c5c..f3b413f94fd28 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -361,6 +361,9 @@ static int ucsi_register_altmode(struct ucsi_connector *con,
>                 switch (desc->svid) {
>                 case USB_TYPEC_DP_SID:
>                         alt = ucsi_register_displayport(con, override, i, desc);
> +                       if (IS_ERR(alt) && PTR_ERR(alt) == -EOPNOTSUPP)

This makes it ignore EOPNOTSUPP if it is returned by the non-stub
implementation. I think the current state is actually better than the
implementation found in this patch. I'd suggest adding a comment to
ucsi_register_displayport() stub instead.

> +                               alt = typec_port_register_altmode(con->port, desc);
> +
>                         break;
>                 case USB_TYPEC_NVIDIA_VLINK_SID:
>                         if (desc->vdo == USB_TYPEC_NVIDIA_VLINK_DBG_VDO)
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index c4d103db9d0f8..c663dce0659ee 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
>                           bool override, int offset,
>                           struct typec_altmode_desc *desc)
>  {
> -       return NULL;
> +       return ERR_PTR(-EOPNOTSUPP);
>  }
>
>  static inline void
> --
> 2.44.0.769.g3c40516874-goog
>


-- 
With best wishes
Dmitry

