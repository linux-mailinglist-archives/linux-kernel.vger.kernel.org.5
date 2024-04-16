Return-Path: <linux-kernel+bounces-147021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C88A6E72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE18B284A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6884612BF14;
	Tue, 16 Apr 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKDDK3Gr"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE4129A72
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277943; cv=none; b=Dau4nRqCWzGi3OP8qsUAvn8RbPQ2xBFHa3FfUWh/xebOsHM0dt93qIVBijtpRDryvvsP6JOppuf2tp1Wv3IdGk3Ck0bHw0CGdt3T6vTZ83lfXUdpCei9tUuK1RD9RHUWGJGgQQZ8WX0HIXWBHh0hQ+i7j4k3xakUsry8kfUz6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277943; c=relaxed/simple;
	bh=TrhX1jGQhTu2KIAciBeO1h+2JzMMjX7NZgRCla9EyWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJSmNgqosshLDXkfvoS41wvuLBMou4ThCGEoTGp5KpYavVqczryzKUnzDJQbBPLC6+aPChXRIom6QaknML7Q3pGf7A6qP2RJnuZRkD9AyT+vLKSQQAoGv5Q+GmJpbriuKbSxs+KurK7Xi+icn96t5at5igxRluRloqol2BFkRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKDDK3Gr; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2da888330b1so35017561fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713277940; x=1713882740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Zyzq1jaXk2PTeBnsS/HFR/E4JVz+BBU5ff7XaF+Dw=;
        b=bKDDK3GrYf4UfsxAMK8VpGZ2ZKJeaYNnJkBzL+ZmgIyU5hfp3QZzb1ZmkWE2xz1r21
         f1L4WiVR0vlml863tNPD0zHCKbylnSKnUdMZdlr479PWBmFs5mDVt47FZatTyHH8ex+A
         6yhlNlvutupCwqauiHVRYzWWrGw5/faAzTRSeCsNx/KWn109+aIMbqFsxqiRd/qB+PtC
         FwNvl75qDSwcgdXwsTSEVO4FheHP4yvGeDzuvkydO+BOqqNYhFUS4G0mH4M9KCsbJVVh
         b+8NVj5P+7bRi/lE8jzoK8uoiQ5BLz/z+LhBAEflD18fy0yJ+RMJHpCeXdeK+HMqS53T
         Xekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277940; x=1713882740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Zyzq1jaXk2PTeBnsS/HFR/E4JVz+BBU5ff7XaF+Dw=;
        b=QDWzMh7eDSQsDhf1qC0BFTgoXNKkk/BzR/WBwLKbCXkWnrmSSr76xGvyzv60FGndpG
         mhpAV6WuUFzZzkvJXbuJxyZvtp0m0W+cch+GB+6XsT0VtY704/VQWEv12ZUluMZOffhZ
         F5xBx7Z8m5kdWvwXXLJpkE7ZaQrdOXflA/wEt5W1U5aOjwXEZQhxZKImQk+00iK9Vdim
         I2vo8Yjpq8CoLP5j58+TV6gDxwblXmBbBpE1aeXkFXBYhwxKGAX9o+HEK3ONAvvfEVR7
         D6xQJOwwvNHFcbpobzAcTSh8bSsj2vsiiFTTz3ugFBhpaIs8XeRwaqUKzXvS+eRwTmSR
         PuQA==
X-Forwarded-Encrypted: i=1; AJvYcCVqTgQb6GWiezkvp2EkcDqnVywc2utkrAdT5Yi5a9RpxfPho3Ey0W1AM+rB2oT/iv26v98dDNw0AXOo03Ws9DsWQnZ+NSXvgleDe8Po
X-Gm-Message-State: AOJu0YxyYTzie2dkRYy9QBs7bG9xSFVFdmoIIf8ImAOaoY3NJeTALy+1
	1hStgnATrtd3zY5ItgABLqFnLElUPKKfZ3iyrH6LXpms7hqwVvmqLUV7JAcrwo8=
X-Google-Smtp-Source: AGHT+IHgRG8rLgID4Qny4NHJoC2rlBQsPSp4jOqaP3Q5e3/gt0VA66TrCMy+WlpbvQARubScC1KY0Q==
X-Received: by 2002:a05:6512:3e0a:b0:519:2a88:add6 with SMTP id i10-20020a0565123e0a00b005192a88add6mr1250650lfv.55.1713277940250;
        Tue, 16 Apr 2024 07:32:20 -0700 (PDT)
Received: from [172.30.205.49] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u9-20020ac248a9000000b00516cbd3e982sm1603141lfg.178.2024.04.16.07.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:32:19 -0700 (PDT)
Message-ID: <c129b349-dfaa-4b10-9b8c-6098d04b9373@linaro.org>
Date: Tue, 16 Apr 2024 16:32:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] usb: typec: altmode: add low level altmode
 configuration helper
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-2-890db00877ac@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240416-ucsi-glink-altmode-v1-2-890db00877ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/24 04:20, Dmitry Baryshkov wrote:
> In some obscure cases (Qualcomm PMIC Glink) altmode is completely
> handled by the firmware. Linux does not get proper partner altmode info.
> Instead we get the notification once the altmode is negotiated and
> entered (or left). However even in such a case the driver has to switch
> board components (muxes, switches and retimers) according to the altmode
> selected by the hardware.
> 
> We can not use existing typec_altmode_enter() / typec_altmode_exit() /
> typec_altmode_notify() functions in such a case, since there is no
> corresponding partner's altmode instance.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Should this now be called from e.g. typec_almode_notify to limit
duplication?

Konrad

