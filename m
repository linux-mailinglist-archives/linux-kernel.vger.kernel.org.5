Return-Path: <linux-kernel+bounces-19073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB0826779
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BE31F218E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169466D6C0;
	Mon,  8 Jan 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCVm+XqQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D227465;
	Mon,  8 Jan 2024 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5981e5d4e7cso1004386eaf.0;
        Sun, 07 Jan 2024 19:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704685615; x=1705290415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb0u7S94W+FH92L7fSkSwAIe1EHoAr/NxL2DTwrFwD8=;
        b=lCVm+XqQoxA9Hz8EcRMckC5gfhifPKAPeDYSICaefaSpu5BR1s3tm/iT7M6+QI7gjG
         PbMEglctHr3cVhWz1mKt/4oQqOIZM12Mr8m99I6Q6+g8sBifizD9ofRcvU7xVpk5NV8M
         BKYkNoAgyCiz6NxG+pHuW8JR2iusA0pBdP9oALSdEqs1mgdL/obHStTggHzo8zdDcseh
         tZ78BHce3AIRckolk7MqWkJdePGDRFEdpwVHQKR2USxpF29CJTU3Ob6bto8opFCNhWGw
         g3HRhDKFaTKhEcHmadhda6vADs8VzwOEo2MOy60lrDslqHeOfEGz0EN0b239efoIzmBm
         KX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704685615; x=1705290415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb0u7S94W+FH92L7fSkSwAIe1EHoAr/NxL2DTwrFwD8=;
        b=O8s8Opu7BhL36GEHc7iKhH7yQJKcWGdUlXBF4fwZZhN6wSL0AYsFdzTAUlRm1cQZWZ
         DiOJg/4cniDz8kms2rPkDRGRW6NPhRNBfkcZI+wHLt2tWQ0Sjkmqwk6YlYPXRCoXKsaX
         c6xa373OOj2R6usSSQrKmRrIxxqyG/0WuhCokHwc/tZreP2CgQWNeolxwiPVHLMC5IPZ
         kbyfMBn0znkJI3sNLBeV5u7j1zovh2CA6gE+1hWKNi2QNCb3hcXqNxWe+LbVLpAg1qhp
         p9F7w0ifQoMrKeABWzd75cIXqQ8WBSHvuv+HIn6JBy55Nn012dRhHjg65D1m4uY7LEXG
         RFpQ==
X-Gm-Message-State: AOJu0Yx82N79pu8gy602klFco1F0Vr5jy9AKxO+5P129ecC/TKuRip+S
	+tZXPqLkVcTDkK54V66Dq8I=
X-Google-Smtp-Source: AGHT+IEJuOGHCM8pqIfMnazDtdcJn84Y5KTI3SeBuOgvoxEvCa/nMB5krImNYtQH5yYjZSq9NiVKZw==
X-Received: by 2002:a05:6358:a083:b0:175:9796:1f9b with SMTP id u3-20020a056358a08300b0017597961f9bmr201068rwn.28.1704685614968;
        Sun, 07 Jan 2024 19:46:54 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b006d92f081d9fsm4963717pfb.31.2024.01.07.19.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 19:46:54 -0800 (PST)
Date: Mon, 8 Jan 2024 11:46:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Aahil Awatramani <aahila@google.com>,
	David Dillow <dave@thedillows.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 net-next v2] bonding: Extending LACP MUX State
 Machine to include a Collecting State.
Message-ID: <ZZtwKFu4GQLQ5AXM@Laptop-X1>
References: <20240105000632.2484182-1-aahila@google.com>
 <11317.1704418732@famine>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11317.1704418732@famine>

On Thu, Jan 04, 2024 at 05:38:52PM -0800, Jay Vosburgh wrote:
> >+coupled_control
> >+
> >+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
> >+    should have separate Collecting and Distributing states.
> >+
> >+    The default value is 1. This setting does not separate the Collecting
> >+    and Distributing states, maintaining the bond in coupled control.
> >+
> 
> 	Please reference the standard in the description; this is
> implementing the independent control state machine per IEEE 802.1AX-2008
> 5.4.15 in addition to the existing coupled control state machine.

The status of IEEE 802.1AX-2008[1] is "Superseded Standard". Maybe we should
use IEEE 802.1AX-2020[2].

[1] https://standards.ieee.org/ieee/802.1AX/4176/
[2] https://standards.ieee.org/ieee/802.1AX/6768/

Thanks
Hangbin

