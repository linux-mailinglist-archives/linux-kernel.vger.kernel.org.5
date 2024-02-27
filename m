Return-Path: <linux-kernel+bounces-82467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064A9868502
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 668E6B229DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D61FBB;
	Tue, 27 Feb 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eR2s4e5z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902A15CB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993812; cv=none; b=GVGJr/xSdPcSTdOmlBGXozJbvQzGO6/B1VOLSOKVIlFPTLYMjvNwMcsXhPqo5eahqpD8qL85q9iSeIkoXX9GIhXcrHG9PP/F2WQjKMAaR63vF1YGL/I1uJks/+3XtsGhV9qa2rzzHfqwx4Zx56mN4veRRjnU9K6cdTh2pcFNQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993812; c=relaxed/simple;
	bh=yVPBQDUjuD+tYmrS/kcvNQbeUvNqDeWFlaS8iuf711I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEblxgNQmgJY/GghBe2EyzG5IIaFy03VQoXf6U6iVa+9NO3gfU8OvwESE7/wFLbhwod2hU4WJRMxyzhRdiJDfHtMf9TpN0PPkngyN41ec7iF8Plfbsbq2fzU6p+Kum7v9WtqLY8eP7QZUpegxxNuCXfCH8cKjwNAonFOFHMRX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eR2s4e5z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so11715e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708993809; x=1709598609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVPBQDUjuD+tYmrS/kcvNQbeUvNqDeWFlaS8iuf711I=;
        b=eR2s4e5znwsnPT9pGFOtWGAbncU1XdkeBcPNPQ1VhkOwzVISpnKdhOwFUQ1uaxwdLb
         1FlQvJStbDGhyVgajge0XyQcoXKH9a2Q17yTN/Zrdgkh0Ek0NDLTTcXOwhXoXmpEe7Q0
         PnhO7GEKmYxZfT6pwsIBKcON3utHf0qY0yBCFfAeCU1/KFQgMfzpIN/o5PcIdhPBsMHA
         s+eWaSisFhUs9ivsrhI0ZYLObf1L8g4+ISgdjql0bq16wLS4mMUIw5bwrVW7y6XSSClh
         Ouxpw/ysxsJUEnpSfUqnkmxtJuxqPbB2aD1LBIRuMIRjFPNSsEcffXBS8G1MSBH5PQ4M
         IBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708993809; x=1709598609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVPBQDUjuD+tYmrS/kcvNQbeUvNqDeWFlaS8iuf711I=;
        b=SMRkAWSo/yBLWCuSGeJ/tdUutBRtE/1t2f2McFnOMdXQ6jKeLB3mM810NTpZV4Vdbb
         IAT/YmSAK4JUcOHdYSe+Jnd4PDWxJboI4BWYYUPb5NGHXtuXTN2aSCI91c0sGmgQhuEN
         SUtUvgJq/TdktyeqftnJ3ddIH36KKZ+tCuTnAO85lWkBCs36D8CqRJrGuve4FFdmxx6g
         Y3ycQfK6pycq46MjtcI38s9ipIU2f6TcUDHt4gnk8AFnKvNZTmIPSncb9QjJo63f6f8Z
         GtLbE+AmiUoutM5Ua+7XwyCjSiAjir+ASIoNi+4CSnBaYq15+UC9qMba/YJ5y9pLFY+h
         LUhw==
X-Forwarded-Encrypted: i=1; AJvYcCXldq91TqVvLIbVI4z4EnwSyRSQybY71o0QF5AXjzM/GqA3nmHhH1yoQ2sT/Htul1FOPhNzazkT7WVicyHToJhEzuMnqkKCKaG1/qXx
X-Gm-Message-State: AOJu0Yy7Nm23X9dm+avrnO586EUhQjXo1JNXzqJj12cxUL152lRzoeop
	VxCt1csfanNtrIbp3a5kI8laCLol352CBf72qMFxQq4+6j/rPU0a3IxedWXzBiGO1lw4iXYXndh
	VTgABkPbrtruCA0MoOyFnK0Tu+AoP0rLMCXv5
X-Google-Smtp-Source: AGHT+IETEJC6f2+EyT5GONac3YZaKpAj1sMifOOHbQn+MKI1RFrZIS7AeXrjdAUkcx1iBNdjj2pwYCdvplZy/5AoYzs=
X-Received: by 2002:a05:600c:1e15:b0:412:a0b4:c7e8 with SMTP id
 ay21-20020a05600c1e1500b00412a0b4c7e8mr47082wmb.5.1708993809089; Mon, 26 Feb
 2024 16:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com> <20240223010328.2826774-2-jthies@google.com>
 <ZdxQaTmhF9q7A4p3@kuha.fi.intel.com>
In-Reply-To: <ZdxQaTmhF9q7A4p3@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 26 Feb 2024 16:29:57 -0800
Message-ID: <CAMFSARftofJ=iox6zy_23PhaiHgKgtwcc1Qrc0RqPvCmCeePkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is missing CC stable.

Ack. I'm planning a v2 version of this series to address the other
comments and will CC stable there.

