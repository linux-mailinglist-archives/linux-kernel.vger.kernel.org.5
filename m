Return-Path: <linux-kernel+bounces-70800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F080859C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5991F22537
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D324208A9;
	Mon, 19 Feb 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+oI5Br9"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEA20324
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326279; cv=none; b=c4irJ062tFWqv9gHfiU1tZHJmd3IDUqOF+BHUI+ZqOMA7AyiZCGu0W+zPJPANUaHbMlnvgVLJPhYFvTbBlk77aE2O9iTi04GW7PevqqJ0FS3tYVp2yMxRHoTqUqglsC5LfLe+qnQUCg6/a1PzJMvR4awowiSJaOTYrnkTIyXRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326279; c=relaxed/simple;
	bh=9BF4VHYAJQVC+PMso4qtHthrHGU8sETSviqlU/rlT0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWh+BjQtCEyBghKGj/tW36EHsIW7k/gxTezX2xwVBN4xixCUwTy5JxcMB4LT/1Zk4MglL52dQswFqx+MMwr5pMCV0+RImvtcEo0xIS16xno2BugYCrM6aRVPpuBWxeaIERpNV49SlESJKH9IxGqIidv2K8/EvK5I3e9nriDwwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x+oI5Br9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51197ca63f5so3592864e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708326276; x=1708931076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9q1ZHX4OCAaTYBsl70W1Bs+lwL/VQjxv3nw/B2A9Ag=;
        b=x+oI5Br9rT4Hepty1PvWLVzzUwalhhh9ljvSgAS+Ag38AWM6E7CJLTVF6ie9+nfc94
         YPZ3qarnXR2j+SsASx75FA8neKQM10XXbPkR4hMlWfkUgqf0Tkyfl1do8uOeFG9FAhYZ
         l7ly6c0F+GtMqFB9BluEUJqHTMI9jPZpejpgsCIFaWIIwh8zu3o1lKtg23BJ4ugoVsC5
         N5XyLkZfqsSFwwguHflwHGAvmxYv+Zz5HC+Tc5RTkgcOGep4EclbmWRQCdlk4uAW77g4
         UaN2N65/wuxvL750sgk16T+pRZA9l7CQKo5vs/Te23EdaHiDlMwZaJxZap0tC4aLAFnx
         v99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708326276; x=1708931076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9q1ZHX4OCAaTYBsl70W1Bs+lwL/VQjxv3nw/B2A9Ag=;
        b=VQgX6iqYWomjiEfCykaBv8c4pL+s0Oix8o1ZbfL/pUJbIQzIbDKMHVlQg6OB0danCL
         h+yvBYreBo1njkup3Y36LuBMiNbJDDAQETS3SGgtNR7vZYhUM5lFKlJN2tL+vuOd+6/7
         OnIGnLnNG0ybNH5cs9cmqfFWYsKZh0zVc7lTYXeuyFQb5Nhb6cQ5lep2gQOK2pcnd/Dg
         e061BLYYTKmdECeLtcH+w/Dw9pt6PUtOGpG4VV2TpwZB841uqFtSs20UijRkufvfmSvG
         GEP3r9Lus0GqEagyI6kK9waEpDc7Kg25vnToHVCH1jZOPOVgXcMtuEQO5pzAN3JlCZJ8
         KcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQBF9AWKlZyb5p3UbdUg7gU3Y2ca3HjS8+jkemsHTU88r3K1N0/oEW3W5WZHDLC0PHGPt0+b92fxMNs1Ri2jA0OcAVGyrCpAfXJS4s
X-Gm-Message-State: AOJu0YyW9KSKwLb6BnCNGNvWX3NbkQXH7tYCMM4jj5EiL14sjrVLFbiW
	kzJxuTUXPQEY6BMDJXjUCWW8xRHsTFuyQU3J+IK5yhXsEclsGtr+QcMEJ3r+lDq8q6w79FgLpRM
	Fv23JR4QLOhF74xCDecwYtTDZGi9xvvSL5FqVll/w7dFr76gE9fI=
X-Google-Smtp-Source: AGHT+IEebHOoNBoc5A7Fsyh8Lvb9N9sknu1CjxwyvDHBhMTXgUt3UbEPOQlP/rUCndPPxrNmxJYr+86uDDdIa3p0NZc=
X-Received: by 2002:a05:6512:744:b0:512:b24f:78e3 with SMTP id
 c4-20020a056512074400b00512b24f78e3mr1341708lfs.6.1708326275918; Sun, 18 Feb
 2024 23:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 Feb 2024 09:03:59 +0200
Message-ID: <CAC_iWjJ_TS66KG7uGOQFiKGfZNKjnod6u7zua4LVK-EJHEUv8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Add get_event_log() support for CC platforms
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> To allow event log info access after boot, EFI boot stub extracts
> the event log information and installs it in an EFI configuration
> table. Currently, EFI boot stub only supports installation of event
> log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
> for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
> support code as much as possible.
>
> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

[...]

> +void efi_retrieve_eventlog(void)
> +{
> +       efi_physical_addr_t log_location = 0, log_last_entry = 0;
> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> +       efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> +       efi_tcg2_protocol_t *tpm2 = NULL;
> +       efi_cc_protocol_t *cc = NULL;
> +       efi_bool_t truncated;
> +       efi_status_t status;
> +
> +       status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
> +       if (status == EFI_SUCCESS) {
> +               status = efi_call_proto(tpm2, get_event_log, version, &log_location,
> +                                       &log_last_entry, &truncated);
> +
> +               if (status != EFI_SUCCESS || !log_location) {
> +                       version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +                       status = efi_call_proto(tpm2, get_event_log, version,
> +                                               &log_location, &log_last_entry,
> +                                               &truncated);
> +                       if (status != EFI_SUCCESS || !log_location)
> +                               return;
> +               }
> +
> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> +                                          truncated);
> +               return;
> +       }
> +
> +       status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
> +       if (status == EFI_SUCCESS) {
> +               version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
> +               status = efi_call_proto(cc, get_event_log, version, &log_location,
> +                                       &log_last_entry, &truncated);
> +               if (status != EFI_SUCCESS || !log_location)
> +                       return;
> +
> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> +                                          truncated);
> +               return;
> +       }
> +}

[...]

I haven't looked into CC measurements much, but do we always want to
prioritize the tcg2 protocol? IOW if you have firmware that implements
both, shouldn't we prefer the CC protocol for VMs?

Thanks
/Ilias

