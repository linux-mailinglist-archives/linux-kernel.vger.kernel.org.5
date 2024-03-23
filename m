Return-Path: <linux-kernel+bounces-112148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57C887642
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8611F21A59
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9010F9;
	Sat, 23 Mar 2024 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D3t7J/ea"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E7610E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154868; cv=none; b=ZcYziB1emoZc2PH1kH8yTdYRc8SJovDt0wSETWVs/PlIfbS7HEYOFywstuKOmuSE+C1mYlknZY3IHA2/zxT+VNKqytAnPYhJ3ly9tNkyzs1ouaiDHwPOoA1UrzH5A6TtGsLKo2Igiu9Rs0nQEk+t5AXflv62niNfXVQVqI76mL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154868; c=relaxed/simple;
	bh=YPvEh8GGyAWNYBq9cCuktoirQCoSq8OiWTRgCg8BhaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0kBrzVb73VK0OOO74Y8uljHNE/tXIZrzrKS2cb9W1+vgs8UYpFD/NbYFZnVuL+JYS6K8xbJDbV51B6kuB99WmNGb8/EBOi2faNWVaT0X6qDwzZZcqPrgKE9+E2GzFxAJXKesrOUjoPiMjazKgO802JLEJdj3H9Kfa8++gI9+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D3t7J/ea; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1def89f0cfdso28170355ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711154866; x=1711759666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifwO8MV+U8fHsEV380klKcwxmnbQH9YOBNoSAhp055c=;
        b=D3t7J/eaKYOFmdRC2AjmQk0se5DsuyYrE3SCt5XOpc93UX2s0KznP84EnR8WNErd9T
         1prm6rgEAjxP5j2ZEUNlXnqZGmJc1fmH4VltFmnOFhJ1D+iANwkF0YIc5ii9miOwxpM7
         0DqxLFPMdy/mAGmegeTefZpe0POUetyJzrx6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711154866; x=1711759666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifwO8MV+U8fHsEV380klKcwxmnbQH9YOBNoSAhp055c=;
        b=oNI8dcHar+M0PgrKq51Pi71TsBhx2kbl4bpD8CkPWPr6bVx+GGVPapO/Ws/2MLztC+
         H7T5yK8Z/YCvkPiEA2/vDW6hdMeIGpwxTRC6XjJkCJ0Oni1eXiXeR2tjfmk4/+DeEaaA
         Z/6EUrlG/cBAc4ZMKNh+c/SPy8YjNT5+Vy5INrhakWLRnuSiD46w95IwgoKTai2Di9HO
         /j4HSUqHCHQ0NnXmWoPCWCwkbq0DbbrfHOz3mrh9MkGXiZMhFvgKBRhgGfKZ//C8uQvv
         mCy17B70ez2A1s5ykHBeaSItDmljgdRjy9x+4275bTFkayColafQ+xSk1zu33JUTg6t9
         y2gA==
X-Forwarded-Encrypted: i=1; AJvYcCVpbr7eY0Y+Igsr6xs1g4MEbGE387eg+oiuOD3p3Nsoga+XKkAWIXotJiFpgYFFscqOtZW7jS3mx6mgKTe1rNO2NGOh7JksTCdmsjkE
X-Gm-Message-State: AOJu0YylGV9I2jZ/8SEd6jqpFLCmqFeCk4WX7rQcQPEyxRvPGp9iyXZ9
	iqJYdHqU9ATaU5M16oLmySNZ9H/P3GAsNavGAl1QRUjqnhjKCTRN52M5MnpqCx7VkBkr5Y1agez
	0WA==
X-Google-Smtp-Source: AGHT+IEYYBQoPCbqgsoBTUzTjsAJmBtl5cuYEV05iAqCeBpp2CszE8iuxt/0ErPK9RSra4XpuJ9x2w==
X-Received: by 2002:a17:903:234b:b0:1dd:69bb:7f96 with SMTP id c11-20020a170903234b00b001dd69bb7f96mr847427plh.6.1711154866269;
        Fri, 22 Mar 2024 17:47:46 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c164:9ab4:de9f:5f33])
        by smtp.gmail.com with UTF8SMTPSA id t3-20020a170902e84300b001dcf91da5c8sm372788plg.95.2024.03.22.17.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:47:45 -0700 (PDT)
Date: Fri, 22 Mar 2024 17:47:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as mwifiex driver reviewer
Message-ID: <Zf4msCV3eGqGL6-U@google.com>
References: <20240321163420.11158-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163420.11158-1-francesco@dolcini.it>

On Thu, Mar 21, 2024 at 05:34:20PM +0100, Francesco Dolcini wrote:
> As discussed on the mailing list [1], add myself as mwifiex driver reviewer.
> 
> [1] https://lore.kernel.org/all/20240318112830.GA9565@francesco-nb/
> 
> Signed-off-by: Francesco Dolcini <francesco@dolcini.it>

Acked-by: Brian Norris <briannorris@chromium.org>

