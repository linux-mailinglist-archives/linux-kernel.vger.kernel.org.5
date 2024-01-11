Return-Path: <linux-kernel+bounces-22914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96B82A55F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C688289D05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A5B650;
	Thu, 11 Jan 2024 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXEUmyV6"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2536A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so4070284b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704934018; x=1705538818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t87NqtyBPvlDEi+zC7NRG9tmb6vZw5mh2mfvHigIApg=;
        b=nXEUmyV6Y7oaEDtTOnmTEGB8h4Y2m4GmvaG4En0bTDuYDxvom700gusAGp5IAZkyV2
         jwbhYzu7GxSQ6tK9dH1471gh/mYyNly6wLYyzji0E2s6fSK3ELlaaLbuUtcoIGNZMO4r
         42LEduN9faiykWKmCmg8Rfs19bOPj+FVdy9io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704934018; x=1705538818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t87NqtyBPvlDEi+zC7NRG9tmb6vZw5mh2mfvHigIApg=;
        b=cTO6OB+0U1bCusbkJrHnigg+cNO/+L/Gy/8F0jM+R1kO9a1T+LcdkhYMk5sIo/9AFb
         01ioTDM8ZEIrYEp8pURIfpjaa9L5M8VIIfUj1c4G2l4D5TiU4RfUSn3ncY9GCagElZAq
         oSTa7WOiyLtSsvKFQ6enLhU0FGErkICW7/9pU3LNIaS3dVSnTD1YNebeLShaVCX6A4RM
         avWjCI9GK9G8D1JX27HYAoQvGhYu7iAG1GEMjHUKWewIlwlvhvXBQp7ihigSMQtCm7K6
         zyO93+d/bjS9psEe27vOT/GlCEZkGK+aTdx9O+l0RsMZu8dyCtPUxCDPsn6UctmpMz6t
         77LA==
X-Gm-Message-State: AOJu0Yx2k8bAESHonLEp7niyeIzW66BvNWHqRzxqfcdJvjQACq+J8/D5
	E65M5K5mdy3SFjJZP/o0ywEro4arAP1P
X-Google-Smtp-Source: AGHT+IElx42r49I/rD/jaQ/XX+0UmK9popst9yB9ZIH+PZO50+ExBJt8eCpRJe1aLP/aJwLheiOXYg==
X-Received: by 2002:a05:6a21:2792:b0:199:a1d4:76dd with SMTP id rn18-20020a056a21279200b00199a1d476ddmr229060pzb.93.1704934017955;
        Wed, 10 Jan 2024 16:46:57 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00171200b006d9ac481eccsm4150239pfc.220.2024.01.10.16.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:46:56 -0800 (PST)
Date: Wed, 10 Jan 2024 16:46:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCHv2 2/2] Compiler Attributes: counted_by: fixup clang URL
Message-ID: <202401101646.61CD91B@keescook>
References: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
 <b7babeb9c5b14af9189f0d6225673e6e9a8f4ad3.1704855496.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7babeb9c5b14af9189f0d6225673e6e9a8f4ad3.1704855496.git.senozhatsky@chromium.org>

On Wed, Jan 10, 2024 at 11:58:18AM +0900, Sergey Senozhatsky wrote:
> The URL in question 404 now, fix it up (and switch to github).
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

