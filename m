Return-Path: <linux-kernel+bounces-99674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A722878BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D1A281674
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666859167;
	Mon, 11 Mar 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAfP9QXT"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42C58AD1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200878; cv=none; b=UOPcIKaqboh6cyKIjEylf8Wzqp6Dn1iZFKEyDdWutOCM6px7p+8QIznqVgNpsC8J+jRw5SlLqXayBOWskRQzZqGmPS6FlVsZnaSdNrZGZaFokmNcZVwFJAu64jeC4Zk46Hjube66MPlButPAYneQ19Lr0XIX5vdcSQGieeJ4HHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200878; c=relaxed/simple;
	bh=47I9y9d6m+sWHb20BjXAdG4iVoGGvHvr9MoKNbZqVB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgOTvR6F3gUqeTA/fOap1/yt5Bk+IuSLtDDIA/E19oD59jgzUKKMSvLntxCmylnGSsm66YRl6F7Rcm51CQZB9NfkLjjHSKtfVVy0O4UyPLfK+bKP8pemyWvk8cj1aGTdQaO1wChMRA9X6hUkArTnlS9hbgMgbzHYJwNSll1c9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAfP9QXT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso1686a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710200875; x=1710805675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47I9y9d6m+sWHb20BjXAdG4iVoGGvHvr9MoKNbZqVB4=;
        b=mAfP9QXTQvwB7FdLdUoeWQtnmDkg4GqIskq0q6UZc35z0GfUz3gpTlDY1AwRh0ERD8
         MSEu7JY939Jpg4wGpvqPdjnIYssaq+QYdfppwmBOR2Ak4utQ+lVffWVcgw16KzFFzjQ/
         kI5WoJCmvQzIwtoxoddPuY2Qba9pismti/Iu+2tHF/ouPPm4iSvp2vn+AoBLZtLjR67K
         G4peMNF6VN9WUMU9/xhANc6QAxBM9aFKmmR0G63IGzmgqanvc3ySkwPiOBSvcG1Lqc2C
         zMB65sdXg9qRhe135RZ0WlTfqXeW8Tk10GYJILUuKyqJ8CHGvlc8fkzR4wH4I26punve
         B+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710200875; x=1710805675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47I9y9d6m+sWHb20BjXAdG4iVoGGvHvr9MoKNbZqVB4=;
        b=SJnIPLCckmQaRzaOpXt+9WUY/kmyUEwy6OoeW/ljaGa+GBRg/HYchf4iPjVEuXBuyb
         b+Y2h0ZaVvbUjJ+pt4+XF98kzs6W+3zR2KhLtn+ArQ3u+iS6gxH3qj5A0DW0fS+0E7BG
         Ph0xzlticK/6CeErCJc7QiV3ndg/Li2kuwkdMBJlrAe/Df5lb1LZkynWLqBPJ8JEzSNN
         nGt75J8DWIY2HFQEPzF9rKLjtH97+DYh/u3kr4q4U9C8YwD2xgKGdW1jADhzKPtak2Wk
         DgRUWTQlN8yPboY1EyL2kn6nx7UwO/pz6qeyf4rbyiBW90JFaTtrVCaoFHyLuMUu+an1
         NNXg==
X-Forwarded-Encrypted: i=1; AJvYcCW83Ce3RW2Z1Q5ucqi9pVY5MiK784IQlItDKXPJfRR5UygUuxJcP+dhJEUwjgFM8Xt2/j4KLteA5IdUgjIrH+g4ZWnvBwo0tbjwpCA6
X-Gm-Message-State: AOJu0Yxm9OoOBl3+c8i3RoXKBtHuIH7EOZ177cwaOEZqdpZdyLpdMaD7
	YKR2tXnZVWBj1YwMpTYhXiRsENnah+kUIIP37R+wZl0cfLRikdw0ws2esJ3bP7s50sRAcXP+nZc
	El6/A+tNm6YGm1GJlKXBBPP/4XUFl0nivR8Zw
X-Google-Smtp-Source: AGHT+IETgRPqiRPbjXlytKWnI8hu5RRmZmhuCnz7VkKXbd9crkp5Z06XYH+DNdrtU45ZfgOq+m/uFl50UP0/GeFNtkg=
X-Received: by 2002:aa7:da44:0:b0:568:55db:8c69 with SMTP id
 w4-20020aa7da44000000b0056855db8c69mr72961eds.4.1710200875068; Mon, 11 Mar
 2024 16:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305025804.1290919-1-jthies@google.com> <20240305025804.1290919-3-jthies@google.com>
 <44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org>
In-Reply-To: <44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org>
From: Jameson Thies <jthies@google.com>
Date: Mon, 11 Mar 2024 16:47:42 -0700
Message-ID: <CAMFSARdZLnfUOZcKVFNCwq40bEZgk0Bo_Oe-o8o7iKk7gQ9G2g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY
To: neil.armstrong@linaro.org
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Neil,
thanks for catching this. You're right, the UCSI driver doesn't need
to be sending these commands when they are not supported. I'll post a
followup patch properly gating ucsi_get_partner_identity and
ucsi_check_cable.

Thanks,
Jameson

