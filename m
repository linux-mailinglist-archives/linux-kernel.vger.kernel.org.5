Return-Path: <linux-kernel+bounces-168100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F28BB3AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC731F25441
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233F1581FD;
	Fri,  3 May 2024 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAn9lVUd"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB512F38F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763136; cv=none; b=A0sIBTvgoEW/yVfxXR8u0a5JHdnP1F+W2UiF5Lzi1z7E6ZfGUV/HAfS0ZNQjmc1rm7LrJUkAmizpxhTNo/MgDhARIkC25yCE3vn4CShE4wFeTRsCz9eE6sZl3D2wTZtgQGeK5CrR9dEhgjpdyvvM0uhUbfuhio0DDoqHtzh3sHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763136; c=relaxed/simple;
	bh=TMPkLz1Rk5l8hUIGUHp3SUhVgs+0VIwtmvyAzaSQHtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/7NOKsimakb/rVfHzRWZn8lb6soyvKJfNt2HHaU6WvQVQW+7MMIAnL+48XoGWsEBLCl3JUsLDhc3kTdJKZqoT4EJq0UgdMmNRn8gOTkxYfWw1/gukBOX3sf+uHtURoLijySy7288l0xzMKmGXiFUk1doxJCYO1ZDrl7OVRhCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAn9lVUd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41bff91ecdcso12175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714763133; x=1715367933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TMPkLz1Rk5l8hUIGUHp3SUhVgs+0VIwtmvyAzaSQHtw=;
        b=dAn9lVUd3da+FdxDry6DJiNayIO1O0j43Q4Tgly0Xb6jyXi6iUdbn8gXVw8FpLCSSy
         E4XtAPtbzREcB9ylS9itaJRmWvzd1ZOalJDrVNBqrwBDCUCZv2ocjvZGo3ahD9vvCnBa
         kh5SW1FHkLUSclDnunN3dywDLiiCY2+S1YPaeUefqv7roM2IhuhBrfqyZMtYDt2Y7CLo
         oKBlUH/Q8IAIbLIpwh5Gw1Pvyrrt2IOVBzaPyLjHU123FhyoqmcQ4ikfZnKDNQuw7p/f
         /bf94328qS/slGUpGUNFJardfW5+Z/ITb8gRLYuVLb2Z2VdrL/gIZ4/zHCJxq84gQ4B1
         wWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763133; x=1715367933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMPkLz1Rk5l8hUIGUHp3SUhVgs+0VIwtmvyAzaSQHtw=;
        b=BzXWhmku0xPh5tiZWQgHnowXhfAblhdkI5hfKJQxKHblfblehVC8RLuLPyGilWby4H
         K2q7gxzQ/QaPGxiy4vfBWhSgVQRyqgQ8wqgKRnmyHTxWmYZVq3E+PA+2C18o36g/Lz75
         KDoarV7l+zmqyj0losYROQHmsNSqKVJDz3+1T9dT+b5RHaVvKPjLAkEoCbUctbBS7Nl7
         5iAVN5pgG920fYfLy7OmutD7+W19yKmuD5F6fNEoLhcfljlybOAnCjPOZMudTHBiiaLB
         5CWWf6+FUVAuJPFMRLMfPyG6rmYp6HCsxEGRgobhJbpEEC8cSTU1tW+AtEM1Zeogkooz
         KqyA==
X-Forwarded-Encrypted: i=1; AJvYcCVnB3I2poa34uHcVS2S2VdActA261Zp4A7aPHjiX/BkOsmwfABkQSpm7bhhDLaV/SAvcY5A9S+dQoYhCZqw1AceHL0WpE7w5fZK5vB7
X-Gm-Message-State: AOJu0YxDrLmzGdb/uY0S99LvZbm8k573BqH74bhEcSsCGI+cqoTDl3II
	QKrAjkPA/HDmgpOHNQtkmizstrkSvftZFki4SGpsRjTL7YF/uuEi40OebJsJXqHSb7nAMrKuXXt
	X3Blqk2VtleEVREvvzc9rsGMg97InsaI94h/iBKTu/mOy/qOe8LCl
X-Google-Smtp-Source: AGHT+IHZ8sS4fieprHPXKuhNEWGMwXDOzkCGeSsHEiwmvbVydjjUM/n4xrCSSVc3A4FP0QOHDXDRNSYqyHY5Wg9pFM4=
X-Received: by 2002:a05:600c:511e:b0:41b:4c6a:de7a with SMTP id
 5b1f17b1804b1-41e5b0eb9aemr195745e9.3.1714763133013; Fri, 03 May 2024
 12:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503003920.1482447-2-jthies@google.com> <96d63b0b-3258-4bf6-b75a-06eb4f4253bb@web.de>
In-Reply-To: <96d63b0b-3258-4bf6-b75a-06eb4f4253bb@web.de>
From: Jameson Thies <jthies@google.com>
Date: Fri, 3 May 2024 12:05:19 -0700
Message-ID: <CAMFSARdhyWAFWr6qjsabPN6k=sK9LLxOaoSNkVLyTKNE=drSpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] usb: typec: ucsi: Fix null pointer dereference in trace
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, linux-usb@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Benson Leung <bleung@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,
thank you for catching the typo. If I upload a v4 patch, I will fix it
there. I don't think it is necessary to mention changes to the commit
message in the section below the commit message.

Thanks,
Jameson

