Return-Path: <linux-kernel+bounces-22913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A0C82A55D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB4F1F243B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088865B;
	Thu, 11 Jan 2024 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HDgP3C5j"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACD38F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d54b763d15so22676295ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704934008; x=1705538808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IF4Xvcxm6j5XwtG4JWml/8dwXU75b8X3960fnN+1LE8=;
        b=HDgP3C5j3R9BBX80ygF/WnAuAhoI4F6f+GwSya8FqqiY3Hl6UIqduBGPG6urRwvOUu
         mDVKlllk4DlWvdwvn9GI4DmK8GjR1cK9UtsF1r2Xd3Evg51ryWtiYxYmoQuxfYpBs8DT
         3WQWB2La7igBWa/BXfoDCSxh2bXbBCHMyq99g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704934008; x=1705538808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF4Xvcxm6j5XwtG4JWml/8dwXU75b8X3960fnN+1LE8=;
        b=YJtNtgzkfwH0rFYdwNWFLX4OAvAoJf1sZo6g80g6aVS+1bnSVYNDBLuRQbBMGyynq8
         HDWO774ks1v/6U6lFd+vrR9gIdc5phPf6eodJ/olgT6JROrwqQfBwBBeCIioRjV4gp3+
         wo6TP/vwpdBzBBCtW4xBm4fud9o2876xchj6W4KFKpYxEBJP0qmVoeQi9C/uTf6Y12PI
         TSugiWvyvHz7O2rd+LXFRWVUUwUb/3CaxLIPlvngWv8kOphnQnLFaS5Ty022+vmLTvZR
         lgGtROkgBw5OXJDxq/Q0eFbSWIdUOkja0S61PdXm6YcCgpHJAhCznXZLOzRFkBetx07L
         /qlQ==
X-Gm-Message-State: AOJu0YyUt+Y78WLzszoa3sLavF3Fds7LZmEdnbN0LpDR07AZ/d9HRbJp
	83uRMxQvp+7DAz9VAgoNc0jvmG0HycJS
X-Google-Smtp-Source: AGHT+IHfIMaIThh7fEON8bNUNbntBfmRsGbqmlE35pfg4eCeS6WcC93NRpnXZIHiEcrfLsuVVhG/cw==
X-Received: by 2002:a17:902:b489:b0:1d4:6a34:b442 with SMTP id y9-20020a170902b48900b001d46a34b442mr331087plr.108.1704934007750;
        Wed, 10 Jan 2024 16:46:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001d495ec2cdfsm4257358plw.33.2024.01.10.16.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:46:47 -0800 (PST)
Date: Wed, 10 Jan 2024 16:46:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCHv2 1/2] Compiler Attributes: counted_by: bump min gcc
 version
Message-ID: <202401101646.B1C4FDA@keescook>
References: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>

On Wed, Jan 10, 2024 at 11:58:17AM +0900, Sergey Senozhatsky wrote:
> GCC is expected to implement this feature in version 15,
> so bump the version.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Yup, this is good. Miguel, I can take these patches if you want?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

