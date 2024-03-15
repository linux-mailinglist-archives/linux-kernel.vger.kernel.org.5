Return-Path: <linux-kernel+bounces-104628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C730787D13B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C64B22759
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3C1EA7A;
	Fri, 15 Mar 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqoXWUly"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588028FC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520529; cv=none; b=f5Uysd4tuQx2EEHrOVnH7QxWFy4WcckJz20/FotS4R3DSQ3S8Puf0KP4hId4PnXn43c1tt8pQjFOcjm2sPWqxwig/wmBZGXo/xOb/zGMlaP8zi/RRFENeryadd6KGyNhlhBaSVmYlsR/njJLmh5/v4MIVEDokCVSJpo/u2tCjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520529; c=relaxed/simple;
	bh=ghw1k/+pt/ZvrdwVjLVvv3tNq9YHf4zCFABTTJrTcKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwnC2zv4Wn+OSBsB9gRjR0avSkU2E1PgGOC0v8O6NZxbNbSLs9813TiT5yWjfexLDrYTq03TGBVy/QBqoDGOnZJoU0PMoEO4bsjqmFq8TNlTCL9bssTJNlL+5YUdheqdoqkTTD2CfIx+sXugr34RortzB662E95gZxvvh19vqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqoXWUly; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso13790a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710520526; x=1711125326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghw1k/+pt/ZvrdwVjLVvv3tNq9YHf4zCFABTTJrTcKU=;
        b=qqoXWUlybVMBx+mnXrUppo7XMBsADPevjOqKcGDpE7JiUU62xmmjGBbsn1wraVixsL
         TkLVpmJPMbquRJIfiNXQamr6PEZVdNjSfF5b9qht8xqwW5/iq0FYBMg87fAMFAkfK4oB
         mAnOyxyrrhVRVPGmwK/b4UEooDhXXPn6WKrsdMx/KE7F6BaCFBPelBSAFEzyk3VyRc2E
         hhmPeJuIy+zrKVnhha8So68hxhOUQwuNOx9wVlhBIoiRgJ8RwMniOn1K06ywemjP3jeZ
         qoCALuSL8WFYQD91U4ach4GKIRffuf6TktoCBThtcGDH6vfLZ8YcWOUTyNGU6+xSGasY
         2kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520526; x=1711125326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghw1k/+pt/ZvrdwVjLVvv3tNq9YHf4zCFABTTJrTcKU=;
        b=fDOaI+Pi7e/t8JFSM5m+FvWK/iPmaa+JQmytvzWm4vi6X9TEcxr58CCAVyWrvFLYu3
         KXCJ1hYn8FwPTvVfdpX3yhX0slwv5pgoaOjNkummQ8rrBiGHxJjq9/p3+0bJ3HisQ/ga
         0NX5ygc9NtURoCn2lkZjo+2GgHNQ+oMKFjcSPh9s+Ywm6WtFtLAY0YKFY5Fe+ffZ87aL
         b0ORdPp3BsTbqyoMMn8vSWerZRJbJs4A30Q9D0IoAsc67aPpl2iIK0EvzRrLHs/NosUv
         8z+F+c8lQSQxrxWM83+lKBodsw3XrxnjuOS19epbqisIHrpmTgXFAB/fk3XgHl6uSena
         4vrA==
X-Forwarded-Encrypted: i=1; AJvYcCXgRTK2Aby8Dnac0VvII8LNVZp5afvw71UlzkhUZzW5bOhNJMUTL2G/kzUDLioUpPAgdte70HRUmmyuqLaHS2FBq/BKiBLek9+q63vj
X-Gm-Message-State: AOJu0YzX+fcSj55QozCaGWotEGpV+3YEyd4Rz/6J6fuwrxzhIkWlhWZ1
	T7AE0evqGANHMyKzsEQDflQ+INIKPZwFhpBvvgoWxb+cFYhHKJJzVp2JdYqd8s9LpgpSCOS71qb
	x+E0jHdkHe+Ev1w7W17RdBFQNiZTjzPDA+CHE
X-Google-Smtp-Source: AGHT+IG6GH5Tn4TKmAdmEgYwzsZTPntpiM77HXjvpskWwt2wQYJ3DnOV8PP8A1NiMEvB9H6lsJugLMrVnkHsAx95H04=
X-Received: by 2002:a05:6402:160f:b0:568:5606:71f9 with SMTP id
 f15-20020a056402160f00b00568560671f9mr168472edv.5.1710520525808; Fri, 15 Mar
 2024 09:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314235554.90079-1-jthies@google.com> <20240314235554.90079-2-jthies@google.com>
 <ZfOTHO6FMlpjeQhZ@google.com>
In-Reply-To: <ZfOTHO6FMlpjeQhZ@google.com>
From: Jameson Thies <jthies@google.com>
Date: Fri, 15 Mar 2024 09:35:13 -0700
Message-ID: <CAMFSARcckrrqy-_n2bK-iZAXBkfkyzEyOWjmEuHQxfuUaCSTkw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: typec: ucsi: Check capabilities before cable
 and identity discovery
To: Benson Leung <bleung@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Benson,
thank you for the feedback. I'll follow up with a version 2 of this
patch addressing these comments.

Thanks,
Jameson

