Return-Path: <linux-kernel+bounces-85832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8499986BBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8106C1C22911
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F413D309;
	Wed, 28 Feb 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqf1b/Fs"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397113D2F9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161794; cv=none; b=Dz6f5oxqyZIJSqhzs8dOqUxwrwbFkbLwYqLVyGuDJE6MHW7/Qg+WEhJhC1BCTnYfXHjkRnBF6Y7f/nIUA5pbYSOKzLeVtIF8uzMwwOd2faKIM10BPiArESYgV/1D+PyHTIX7wgmiz4kBsC4SJN3a0EIfwDjmZKdRTIhWKtS/vLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161794; c=relaxed/simple;
	bh=tQPwMcJnWlsfjLGPuN9MxoeAz6jfRjvKCSyaROjNjXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePJRwyXrgCCBOfZKMXcX5rE9lRIxl6Bq59z6o4egNP3sgaK1Gj3Q5qypG1njWUMLGENlGxlKUiJ3XkCA8fc5Qje+GUpyl2TFBAmPYNHnF0l1zjVRECcpIYbMa06Qzzp8OxQniDB/GosYuSA5fMRJJiCzq0lp+0VoZuNXv4t8N8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqf1b/Fs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so11755e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161792; x=1709766592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQPwMcJnWlsfjLGPuN9MxoeAz6jfRjvKCSyaROjNjXE=;
        b=jqf1b/FsASpjqE0hcZWN7Ml8HM15eVWOQU6MZVKPsoQm2jk9zlkEN/U7kfJdEoCq12
         4/ymkPqjC0V8+SYlXwMd7Z9uRQEK7gZ0J933QzAqGDZJ01P6CrhFtnH2jHJhj/8RhX1u
         cj0t1UNZNy5znKsjR0reUHzC5Vv9LHr1TBfHxgIe6/DSF06QLjosb1TbkeN2t7TaDdr+
         hsrtwqxWPvy57IMJyVM8aruvglvAAYs7lG/5lfgq06UV6/mXc/NLskrpb2rWF2TkMK6Z
         MRNMzh/O0ZdzOarYXpKo3MI3gz5umOOmNy7kGn6EGKa+a60XzvbrKRLWkSH+tsD4HGvk
         sDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161792; x=1709766592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQPwMcJnWlsfjLGPuN9MxoeAz6jfRjvKCSyaROjNjXE=;
        b=c3F14OSBGeW9bDZSMDWiqK4i288fi3Mz9sYXzcBTeFvEM9ZhbEabUcI4SI3J47w/eO
         G0pN6tpcEvJmEuKBlvcK4AkgT5vCSxoikfTas7P+LDSw81xhTCozwZ08ajCGerEGUxJ9
         28Xc/nItu0n9VHYqF5UiU7QQu7J7crnHqNYxFiG8vcBNugjif1I4imffhlcfGc0XgGjc
         uOvP9FJjZYUMgRE0Qj8zFtOZabsrZ6B5zUm1zoaHQfHGZpOJ337YOZOC3hbaBgjXPWts
         9aq5oDCLfCN65ep/1BMy2xDITgtPsvGzRGTn3v+QPKeODuECETpZ5Jc2qV47m9wObQnW
         Q9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVo5MPeW6ZW5hVvaFqMg1WXuIDUqr4iKGD346+zTKHm18zSvq9RAKKzNFWEOFCH69khhQXc4rQZeEalbPXugKoglI/VOzkUzHVyaTPl
X-Gm-Message-State: AOJu0YzqiC+yXYbo+sR/hOdu0hqYP9hpf0fU1ndVuc/3NVyi1cgaoIxQ
	/R778tfsU03+eacMN8LdGizGXo7E+InyVnSWRBv68xvkoIEuA0C9zaBgXC5bEYByy8plUZ38bLJ
	61Lpsl8DX757lP7Z2IxVoaxTGCQe34RGP8lnH
X-Google-Smtp-Source: AGHT+IFaBr4ou5rad4Vy2KOF1zJQLth3lKTUU5sXoI0D9Y0AP76f/bm/fMAN2JjwGX5iHC5QewNHPi3Hcv1eyjkFA3c=
X-Received: by 2002:a05:600c:1f09:b0:412:a9ce:5f68 with SMTP id
 bd9-20020a05600c1f0900b00412a9ce5f68mr29447wmb.2.1709161791779; Wed, 28 Feb
 2024 15:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228220251.3613424-1-jthies@google.com>
In-Reply-To: <20240228220251.3613424-1-jthies@google.com>
From: Jameson Thies <jthies@google.com>
Date: Wed, 28 Feb 2024 15:09:38 -0800
Message-ID: <CAMFSARd33yHhxNRkioX6T90+SrFfEVHW9StXToTj_NEXnowftw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Sorry everyone, I CC'd stable incorrectly. I'll follow up with a v3
series shortly to resolve this.

Thanks,
Jameson

