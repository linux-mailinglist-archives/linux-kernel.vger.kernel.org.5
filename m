Return-Path: <linux-kernel+bounces-151976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F18AB68C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0594CB229A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096EB13D246;
	Fri, 19 Apr 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2sIhXgx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65F13CF83
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562945; cv=none; b=sRc1r2gcvOVwDW10BEe8RCArnzIytc9kT1pXMtsUSbimx3JzyhcmwwkAnq0fdsZ9HVk6nkPaJsE/3woHYXnaNptTs2eGvS0wWa5PO5pXIEHG9YVT5wEFbSlGZR2aOmjxr9oTdzcrU8zv+TDV3imEuTC5BGbqBEOZI+dekfhLTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562945; c=relaxed/simple;
	bh=NPxvFmAw5oWXOR1jifx56rqZ4hVthZ+n+Lh95DLTlRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXioCM46PDXwwlK6HjGZ4FLBmORjEYnE5e/8oajG+po5N0eDZTT9mxYGgGstXZDZGzUBjObVFgcQCP2wxgNfNLk3GGoB0RK9++I0IXxiatjZ+pYzTuRP6QiFQuT4ir5Z5Y9Gd+3ZYKnS7Le3epOos/2tE2bmnEqGAbulNWYHy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A2sIhXgx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e4266673bbso23724675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713562943; x=1714167743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPxvFmAw5oWXOR1jifx56rqZ4hVthZ+n+Lh95DLTlRM=;
        b=A2sIhXgx9wXAL1+uDsdGQjFNUYAZjVscI/rWX81NwQjbk+EqMZE5V83mK4eN1ZL71j
         yJNwvvm8vflwiqS9AJwlbL/ITSS5gA4K/I0Gs6/scC/HaEiG+jKZhKABVj8OAJPrdpgP
         nbFhxTWFR5t9PgK5oLQ3Rkv67C+4ENjSHDgvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713562943; x=1714167743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPxvFmAw5oWXOR1jifx56rqZ4hVthZ+n+Lh95DLTlRM=;
        b=TG6rNPx/3klwSA6Pv0Wc9nhhE/DU+o+jYODqbnLklOLe0tsPNTfyZqdG+1YDhwY3tZ
         6tdHFYuC/VILVydTz7eyuSHfj1Diy/pTujkNvKRKJdEKqKxGBIhe2Vt9bMgd7GJw2tRd
         5lpFOKGw3vexKHjBKiDDXRmKuvAM0eMoOb/BosJ9UXLIGmZKlsYE73BC1MNwNmtq+S7x
         pmK6qZS4KBI0rbs6XmpdnivxWRDwGWWE1DLvqVv+3qqgDyChiOANJ978MWzYQqDZeiBt
         O4Lz4D8eMglHGpjDZX8YrF5JCC4BNOTLQRH3vzX79SfbRz3DntjKcKxE3Xs0Xqp1HzjI
         1FkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiZ4UxezsaaRw2WOTN6j6RTTmL8818g2wBXzO2KC4Dbv/LDOCs0B2+OcpxWPaF0sSLlSm/yX7eFs35YTq/AleLH4R8Q/uJnLjHqSqM
X-Gm-Message-State: AOJu0YyR2lXBcrlRE8Wr9PVWzijnRisEImMyQi/IgcYWjfrOs3mo8lod
	nOkXb7guBXt4n8RSPzryUpcT/5/qc3W1kMnUE3ZN5o+LX7ozLms+JdyJZNYLzg==
X-Google-Smtp-Source: AGHT+IFj7eZsZNK1ZUTS2vBLbhWq6Z0dhfv20Qo8btdUxwx+nIPhoi31OWLwp9/zuxVj2TiYnsueFw==
X-Received: by 2002:a17:902:c1d5:b0:1e3:e380:8724 with SMTP id c21-20020a170902c1d500b001e3e3808724mr3328774plc.48.1713562943463;
        Fri, 19 Apr 2024 14:42:23 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3d16:d9cb:3ac9:d53c])
        by smtp.gmail.com with UTF8SMTPSA id w17-20020a1709029a9100b001e2a4663179sm3825539plp.258.2024.04.19.14.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 14:42:22 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:42:20 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"rafael.beims" <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <ZiLlPOvKlfCySZwF@google.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Fri, Apr 19, 2024 at 04:00:17AM +0000, David Lin wrote:
> Can you let me know what does "external_auth" mean?

Look around for NL80211_CMD_EXTERNAL_AUTH. It's in nl80211.h with plenty
of comments. (And also cfg80211_ops::cfg80211_ops,
cfg80211_external_auth_request, ...)

I've never looked at this interface before, personally. It seems to rely
on cfg80211_ops::mgmt_tx support too; that seems to exist in mwifiex,
although I have no clue the quality of support there.

Brian

