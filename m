Return-Path: <linux-kernel+bounces-78993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C73861BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C9B1F2922A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F312AACB;
	Fri, 23 Feb 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOmS4F9K"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976851A58B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713638; cv=none; b=u+J4M71xj3gbruCW7OzL6ViK5wKvi5MOrxIL28qfezXpcMMVHAeWHJyJtg+X3cP00j9Dbk4S0cUXP0AIWWy+96ujkAlCMRfHSMmS2SAwtTeBQwZzpGXLxchmfojH1egRWJdtzsI9oe30+3sfhWOskWzUDPvEa+TXtAnjcWe/OJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713638; c=relaxed/simple;
	bh=TOB4I3kVL0paZ4hfkT3Qqt8no9Jsok7R6cPcghhOfE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhZMwhCmddWnGBa8X5ah9JXI9lJaqOAEgLv3I9Y4rjisiFk5npccchNsctAFm4dkN7tJwvwpNYa5VOB+9JS01aJDCmjO00f4z3K3M/b1VnwZAFRU0BVz/VBoIMm1YYvtextJFn3tbmJg3o5M3VfP+xhU1tL0OqfHwq5b1Mi/sEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XOmS4F9K; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so720279241.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708713635; x=1709318435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOB4I3kVL0paZ4hfkT3Qqt8no9Jsok7R6cPcghhOfE0=;
        b=XOmS4F9Kb73d3P312ms9v/Qn/budZvibIQeQTTa/244BQ/FnnrixG7MvsPSNsSWVdG
         e3s9Kqnvo3cYBvv8Vd5cqDi+3ThR/Ggc1MnomkTu7fyl5xnbQsSEbwpjLTPoazm9eSi8
         SdTABvvb6qVBBElHpEyzv/7TfGMVqkCJDuJg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708713635; x=1709318435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOB4I3kVL0paZ4hfkT3Qqt8no9Jsok7R6cPcghhOfE0=;
        b=Ll3rxn//zDCyzXTx0cyxqmPnukMYrcCUw/eDvEsBumltObbOEoJNUMjYt4G54gT7jY
         l6nhdr+58JF+rQHqgrEPFgjZpvER/LOx8n/yKMWcGmDfdB6BaejQ5a3rkC/IAwix4FWf
         NMsRE9tLfg0kLX7Hix01hIrMNK2s7CYdW1VyPVM9qQnOTEwAEMxFnVdQIy2AXpedU3Ty
         e8TAGKwgyw5/0YuPy7RtYOatRCpN+0HLdraqrgysr4gJG0NJVPKUyPkTuGRGnIa+G3Lw
         LHTcmXUG9FSZaEJWWlLPYQsyfSTMVPcctML3fiLDSZMDjMQNMkAQZeLw6u4qvUYbD+5k
         o1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUje5JdkehVEq7eCOAIfyoTv8UCLSKIbzcyom1JlFh5TsGshfEqkclW9YJF4ft7ppJ3zfSHfqiy81c2AdClrOivFdYm2zq70wjZ/iMR
X-Gm-Message-State: AOJu0YxXnMk5dTI+TA8hl4g4wwKLf+lcEsoazmodzD9flCv5Dnerlezk
	UJvO6WaCo2jn2qHDdePl3QA6Ic3vghgvA92n/+CkctdewEq2y2mNJ8+n3E5uxY15kNPAyAFH510
	vS5O2/88eKzB03Z98NzSarDtC6X8O12xCCMvK
X-Google-Smtp-Source: AGHT+IHfzGOHuuHDBTmLDY0ie0fD0ekcRFPvHSKqTM3fPy/RGiI0EX+T3g0rSkrdu1RSl0uN3IWJAfZxO1wO1jUtPCo=
X-Received: by 2002:a1f:cac3:0:b0:4c9:f704:38c with SMTP id
 a186-20020a1fcac3000000b004c9f704038cmr784493vkg.11.1708713635554; Fri, 23
 Feb 2024 10:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com> <20240223010328.2826774-5-jthies@google.com>
In-Reply-To: <20240223010328.2826774-5-jthies@google.com>
From: Prashant Malani <pmalani@chromium.org>
Date: Fri, 23 Feb 2024 10:40:24 -0800
Message-ID: <CACeCKadQL8hnoOOu8x5mcD=tHMAB9sEVEMY37X8S4vqhi3qK1g@mail.gmail.com>
Subject: Re: [PATCH 4/4] usb: typec: ucsi: Register SOP' alternate modes with
 cable plug
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:05=E2=80=AFPM Jameson Thies <jthies@google.com> w=
rote:
>
> Register SOP' alternate modes with a Type-C Connector Class cable plug.
> Alternate modes are queried from the PPM using the GET_ALTERNATE_MODES
> command with recipient set to SOP'.
>
> Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

