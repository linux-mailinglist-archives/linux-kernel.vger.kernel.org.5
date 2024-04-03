Return-Path: <linux-kernel+bounces-130678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B641897B90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6A51C27394
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC4156994;
	Wed,  3 Apr 2024 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g8EQiJSK"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B684156978
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182944; cv=none; b=IoNCPlC0BempS8v8C2H/DYA46GWDFipOqQL0H8ChQAvGiuNZGXe6iy2IVknYAKQJd+aG30fCFyFB9z1HekgwXNJPbhbMJ9nOf1MNGY/oUcL5uIu0NMlutU2M/KadxSqDn7KTDybRoVsj5o9psQCmNU0aswshdDvKGl/QxZgEuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182944; c=relaxed/simple;
	bh=8t3naentFxM+AS3RtXGPq3dvrdYW71Xqe2UpBOIdI9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2dQTqEKKUd/veT4bdEazRg3p+AQqqc4W+U29K1cc/taUtIFsxmuJQxq4Qay5qcgeO1PHWPNyMmVs60N//ivWzwj8tDsVEe56RulU8JMZnYGW9/K6T+0sRC0izca6nDsFFQaZsEcH2pvXtagSJBjezjn6rnlJ/dQHVr5nTF5hdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g8EQiJSK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecd957f949so308698b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712182942; x=1712787742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t3naentFxM+AS3RtXGPq3dvrdYW71Xqe2UpBOIdI9A=;
        b=g8EQiJSKflI5b/aIAvc3CcFauGsBLsxla5/1VzMbGKnSrKiSAR55HyZDlv6jDBPj2C
         0zSt3gN96BV986nCNpN5QXydXTeEp76OtZOo/hYxlFmE6eHfsbj1jAWtBA0rkpH65X/F
         eFE4zL9zMgcl75+H2U4XVa2JjNrqj+tlejsbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712182942; x=1712787742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t3naentFxM+AS3RtXGPq3dvrdYW71Xqe2UpBOIdI9A=;
        b=idAQFMeQEKMRLJ8n0559iwA/v2bOft5yp4lqIxXnOS9fpZT0JjEAKBSTrc9kj6jls8
         KrzkNlms4ELqPdAcnjPf/VhqNPHTPnkL50QivrqupENwJvNqLHAT3gaiNnqnTcxvs5Xi
         GMWQoHflZnOX9mkDRkr237fUcxEJ2oRNmjq0qcWE0l9euKEXjhoOekvbBXSEjOCIA579
         H3x+q4D5G84F97c8OhVhBcGxUYex+FvltrKR/bj3Stenh6U0vfSvayqUdhBWa1yElDGW
         pMuGnAK9A5Hv1vymfR6g+rkyVMzfUgdtnywj8SbczToZwq45Ku8sEAchBxfrmXa8RC5x
         pGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6u4jy4LjZPftnhbNzZM1e3BuObFAiXXb+HTi14gBTinQbgEHoS6NmC0z9/6g9g/ngd3HZmIZ+62YnOrfAd/TIogSgtSpG9II4qZRF
X-Gm-Message-State: AOJu0YzhvlU7apAzR/4oALijlPWI0NvGJZO9uC0zhMZQBdlQJNnWfnuk
	Fb4zs7GzmnUHzj1hh+fcc65DTbEcKlWH4HAyej8D26F+RDHiLvQZDzLAjT+QTHcRxM+fKfIxmVC
	rrpHkf4dkFPeC1YKutAMxEO2giDLPPPbsmpjNhRzjruMDgw8=
X-Google-Smtp-Source: AGHT+IF0pyNbDc5esUhGnGF5JxOyl9/zlljXfso5iU4MajLn0BUuueWKvVRUX69RacB2FaMm84NuPvyEPXR4Y01vDxE=
X-Received: by 2002:a05:6a20:7352:b0:1a7:1e1c:3031 with SMTP id
 v18-20020a056a20735200b001a71e1c3031mr1328275pzc.36.1712182942479; Wed, 03
 Apr 2024 15:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-ucsi-reset-delay-v2-1-244c175825a4@chromium.org>
In-Reply-To: <20240403-ucsi-reset-delay-v2-1-244c175825a4@chromium.org>
From: Prashant Malani <pmalani@chromium.org>
Date: Wed, 3 Apr 2024 15:22:09 -0700
Message-ID: <CACeCKafbnsnvk1pbghf_eRN+RV3_7Q46POm2hQxW+gSt8a5z5w@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: Wait 20ms before reading CCI after a reset
To: Pavan Holla <pholla@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavan,

On Wed, Apr 3, 2024 at 10:57=E2=80=AFAM Pavan Holla <pholla@chromium.org> w=
rote:
>
> The PPM might take time to process a reset. Allow 20ms for the reset to
> be processed before reading the CCI.
>
> Signed-off-by: Pavan Holla <pholla@chromium.org>
> ---
> The PPM might take time to process a reset and set the CCI. Give the PPM
> 20ms to update it's CCI.
>
> Based on the discussion in v1, this should not slow down existing
> implementations because they would not set any bits in the CCI after a re=
set,
> and would take a 20ms delay to read the CCI anyway. This change just make=
s the
> delay explicit, and reduces a CCI read. Based on the spec, the PPM has
> 10ms to set busy, so, 20ms seems like a reasonable delay before we read
> the CCI.

The above information is helpful context, and should be included
in the commit message, otherwise it will get lost on patch application.

With that, feel free to add:
Reviewed-by: Prashant Malani <pmalani@chromium.org>

BR,

-Prashant

