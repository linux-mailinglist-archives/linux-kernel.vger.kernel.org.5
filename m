Return-Path: <linux-kernel+bounces-28590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B82830069
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A861C23B76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759AEB654;
	Wed, 17 Jan 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3wGXtpC"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EB8F47
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705475905; cv=none; b=sop8MT5pJ6iy/rJo/9kIgjlTM0IL9QAiRrQvV4/B4PBXSK6pTfLsZvaZSj5qPofss1dwOzwDVRoiKQtjPyKAJrLSKlacz/MRWMRh6EokEEKF0zOnKo2w8T09BRCGhi+Dk6f09HOHp0edDXnAKmq3Qi3+2w/aHN8AigqdFQ9QN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705475905; c=relaxed/simple;
	bh=C7GeLNiGP5bRjIx6Fc77DzlLph77+xnFMKo5ep5RaK8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=mWs0iM+62JWHTMaERkKG4rnka7c01W6cbPQWSBpWBpfn+u+KQR7Y1kynf9GwFJQSkmKWOqnQXn88NqPxcxjH1WgNpemydfRTooN2sHkVNhKTqXlobmRLx9AGgV9szTnsUWM01CBoQfSOuAdHlX8uCsOmW7Z3DpARmeHL3po0GDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3wGXtpC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-428405a0205so98711cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705475903; x=1706080703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3EQRRw7jZs+7rhvm0pp3ec3+dkHb+ZBu+iZ5gNOr0Ic=;
        b=T3wGXtpCGfOVD18PsxQ0gk2eF85fKmp+c0MSpCMlWUkC4j/pR4mili5lzfmtEOJ0NU
         v+ryiAM2RNshko4x0LABuVCSOYezRiA7bS64PtNe38BkHk45Mh0XbqJOVunPmKzr/Np+
         k3U7JuYvDMY9dBV2+3EV5hzkrUKiAXnn0xbHOkc+jCtlAPWGeON9OXshEEDf0a4bP/xH
         XycK0sTLb67DPCrQt3dyiN1+kHmySpa2H47D00/EkqL5uz3qJ0mHaaTijTYOUNV9hep/
         lWKbWwtfmWswqeRBSIMVyQ0LOHxWDUAo/NXygaXFfL+9jX+jqA2XCQMkDflYi38Cp/uR
         7xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705475903; x=1706080703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EQRRw7jZs+7rhvm0pp3ec3+dkHb+ZBu+iZ5gNOr0Ic=;
        b=fDbV8b2wyuzpnq4LUjDUoalovJoGWmfc6dKigswGP9HLUjjENR4ZmaPPqZXEB6A+o4
         31xJAYz9zGaK87Qjn1A8zQHAgUQ9uenRV1yYjVIAKJOPNRjXrnJyAXImPN5pRmBlhNUP
         BIeEJ/kvIZW9lU2Nb3Vna388mch6PXffwjsllN4s8WTDpXWwynM/isVuJIk5PT3w08JB
         hA9UEvQc9/zQN408Deo+1k6LvTRdC9wp8ayHLNU50wNGCBGmnAmL6TXK/cFwTuY/B8dc
         EbFN1t4Mgze0VFw6nqvTVehSSz2ieLO0MaojnqPVKrYrU7mD6txP710lVufu9EYSMKQU
         3k6A==
X-Gm-Message-State: AOJu0YwsS+j28h5E8ql4JTWBXRv0XVPNRly4C6maWMtRYUlpTIA71F4p
	VyWCHJYcQgpxRFo0nvE0Ahh3skQ2ieE5BZXNEwGXl8COQYgxlik2UIbSzsSSdck1lk1M7qqQDf4
	mVY/NOUmfwDc0Hmmymk7L6HLpcb3AHZUy4Ko5
X-Google-Smtp-Source: AGHT+IHisHbbrW+bz2ZL8LW/3fp6Ge8sVTfhJBl8oWT0mBFwMPn6v8LATZsuXbACVPhDN7t1DQkN6aInw8vCPgmVgk0=
X-Received: by 2002:ac8:6f11:0:b0:42a:220:82f3 with SMTP id
 bs17-20020ac86f11000000b0042a022082f3mr87321qtb.21.1705475903265; Tue, 16 Jan
 2024 23:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
In-Reply-To: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Wed, 17 Jan 2024 15:17:55 +0800
Message-ID: <CAKzKK0qJOz_+pNAVAD8Ub6TZ9uhFOzuDC_bws9MVzxNa7RqYhA@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>         ret = dwc3_gadget_soft_disconnect(dwc);
>         if (ret)
>                 goto err;

For improved readability, we can remove the goto statement and move
the error handling logic here.

Thanks,
Kuen-Han

