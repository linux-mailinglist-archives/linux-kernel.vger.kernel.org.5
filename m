Return-Path: <linux-kernel+bounces-83306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC08691A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B6BB259B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2413B2A9;
	Tue, 27 Feb 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8YEaViT"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C813AA51
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040012; cv=none; b=mGcQrgPnurv9DJTjkN/a5zoTfwWo6GY0DsZTuHJ8zJs4vt4akmtzhsobi8lTI4ZxYpLmSVGrsq0icyEbtYeGjyPZXAQcxCL5MmwDrYeQ0Oe2tD470+hWIhDD6ZVV5RiO/cbB8bKjqfBWzovCRSx6QG5IMyAxe8APNfxUK6zfFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040012; c=relaxed/simple;
	bh=UCc+QXpK/pxCYv6oqRhkjlslZVn9Vi3dZm4sUsqmYXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZH23W7mMgaR3noOuhPK1uPp35MpqOvOYj+MRTB5k1QU6Y/EKhW67Ff0trMP96ncllQNFCrJhT8Pa4ly2UkOFIG0ydU4uFkV4BGEa4g64Ysf42kfek9zNgjrgSQn/knSCR3knNKBC1UQ5Ws5gy9RhuU74ggCVHuWLdTrThZ+y1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8YEaViT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d220e39907so67219641fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709040007; x=1709644807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlr5GxTuTyoOqcx2wy9fcrF4X1fQdHiiP+0pPjt3du4=;
        b=o8YEaViTzRsCM3yNL6D38U0y955k1Yq82BaB9YXlSg8ZRhlEfoYE9bF5yO9LzfSiZa
         FUY/+LEELHeuhqrfSBUvOu+0ubD99/MeqhAbm7qlt33PQGaC14YW6FDzSUrnc0WpLSO0
         uLgE00EnIEivUFCR2hB3R2Kty2HbcWLkBbnex0Snw2nWhJHys8K77b0zpAhXeHPKEVT5
         xT4vQO6e4Hn9XhLn7R6PhhbOO/9aDeo0vJXqf33aSKi2Wqjdjy8WnAiVEP2HtBCKbt4Q
         x3H7G2ZUCbnQfwvBdBcI31dObwJY6ELxlq3FopP+A0yfQ1VYBRa49PhPLUR6ZBgIvyvL
         hmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040007; x=1709644807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vlr5GxTuTyoOqcx2wy9fcrF4X1fQdHiiP+0pPjt3du4=;
        b=XZYNSxWi5lV60HpZW/juOAmNSJg4gjFKKEj9v9Cil9cvhEpVyPnrqLSHyiB/hd4E9M
         2AdBY5IKPCygsc80PxFZNr108OW9H8R+t6gmvxvWdjw/nH2Q0LvaR0DS1tC+yCvhy3TV
         +/QAZEPBTimGT/ekjle33nLtNEmUjPKtvwzoxQX10RAf8VXEr2hk0sysYCQQ20S+1Adj
         fieT/tl+IYa3iG1zeJdgDgbVK5hkIuCLo04xgfXeMyeo2re1B++E41Us5M03fwafGEAh
         Gb8ifE8TgI9Cwek8EuJUHBQGrKV+RkeclYfyym0hRpDJzBfWH8VREMj1tUyS4TjRlNK4
         CDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQfqjDdlgHXKiS06s2axNfE7RCUtAK09xZlI+7ifB3sZiES/S7AgwY4ZpzzP6Qf7e+PnNjzyd/epaZHvC25W1OwXjHwrEPijhUcxgo
X-Gm-Message-State: AOJu0YwShnlzbUi3nys/XY200ifwCasRobLdr/zrT1z7KQnuDa27D78H
	b9MLAMEYyYht0nw7QXT3nDUfQf39dPBZuvWy7+mf6gJ2EQMgjCdPHtx9nUBSAYKM8u1f7hUxwSp
	37FDX5R1zl+UM5MjE0swc1MjkyXvb3dKzZkHtBA==
X-Google-Smtp-Source: AGHT+IGQ5qKugw7EolCixjBBZt98DHlZp0AHzKrqvDtOPvC40Yids/u0deBUUEQVxTX4vweQHoEHToV3hUoy2m4wmRs=
X-Received: by 2002:a05:651c:48c:b0:2d2:5cca:cf6f with SMTP id
 s12-20020a05651c048c00b002d25ccacf6fmr5999084ljc.18.1709040007508; Tue, 27
 Feb 2024 05:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWjJ_TS66KG7uGOQFiKGfZNKjnod6u7zua4LVK-EJHEUv8w@mail.gmail.com>
 <7feb889f-f78e-4caa-a2f4-9d41acf6ca76@linux.intel.com> <CAC_iWj+9eWesWD62krdhLwj58fpjptpnnG5JpUJUpFsg7_GzOA@mail.gmail.com>
 <3b8113ac-e44c-4b11-b494-9e473352037a@linux.intel.com>
In-Reply-To: <3b8113ac-e44c-4b11-b494-9e473352037a@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Feb 2024 15:19:31 +0200
Message-ID: <CAC_iWjLXNBJz2RgRb3vbM_hetnw3hoWpG+sKM1gfiGo=z6tLxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Add get_event_log() support for CC platforms
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 09:31, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 2/23/24 5:24 AM, Ilias Apalodimas wrote:
> > Apologies for the late reply,
> >
> >
> > On Mon, 19 Feb 2024 at 09:34, Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >> Hi Ilias,
> >>
> >> On 2/18/24 11:03 PM, Ilias Apalodimas wrote:
> >>> On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
> >>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>>> To allow event log info access after boot, EFI boot stub extracts
> >>>> the event log information and installs it in an EFI configuration
> >>>> table. Currently, EFI boot stub only supports installation of event
> >>>> log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
> >>>> for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
> >>>> support code as much as possible.
> >>>>
> >>>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
> >>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>> [...]
> >>>
> >>>> +void efi_retrieve_eventlog(void)
> >>>> +{
> >>>> +       efi_physical_addr_t log_location = 0, log_last_entry = 0;
> >>>> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> >>>> +       efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
> >>>> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> >>>> +       efi_tcg2_protocol_t *tpm2 = NULL;
> >>>> +       efi_cc_protocol_t *cc = NULL;
> >>>> +       efi_bool_t truncated;
> >>>> +       efi_status_t status;
> >>>> +
> >>>> +       status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
> >>>> +       if (status == EFI_SUCCESS) {
> >>>> +               status = efi_call_proto(tpm2, get_event_log, version, &log_location,
> >>>> +                                       &log_last_entry, &truncated);
> >>>> +
> >>>> +               if (status != EFI_SUCCESS || !log_location) {
> >>>> +                       version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> >>>> +                       status = efi_call_proto(tpm2, get_event_log, version,
> >>>> +                                               &log_location, &log_last_entry,
> >>>> +                                               &truncated);
> >>>> +                       if (status != EFI_SUCCESS || !log_location)
> >>>> +                               return;
> >>>> +               }
> >>>> +
> >>>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >>>> +                                          truncated);
> >>>> +               return;
> >>>> +       }
> >>>> +
> >>>> +       status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
> >>>> +       if (status == EFI_SUCCESS) {
> >>>> +               version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
> >>>> +               status = efi_call_proto(cc, get_event_log, version, &log_location,
> >>>> +                                       &log_last_entry, &truncated);
> >>>> +               if (status != EFI_SUCCESS || !log_location)
> >>>> +                       return;
> >>>> +
> >>>> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >>>> +                                          truncated);
> >>>> +               return;
> >>>> +       }
> >>>> +}
> >>> [...]
> >>>
> >>> I haven't looked into CC measurements much, but do we always want to
> >>> prioritize the tcg2 protocol? IOW if you have firmware that implements
> >>> both, shouldn't we prefer the CC protocol for VMs?
> >> According the UEFI specification, sec "Conidential computing", if a firmware implements
> >> the TPM, then it should be used and CC interfaces should not be published. So I think
> >> we should check for TPM first, if it does not exist then try for CC.
> > Ok thanks, that makes sense. That document also says the services
> > should be implemented on a virtual firmware.
> > I am unsure at the moment though if it's worth checking that and
> > reporting an error otherwise. Thoughts?
>
> IMO, it is not fatal for the firmware to implement both protocols. Although, it
> violates the specification, does it makes sense to return error and skip
> measurements? I think for such case, we can add a warning and proceed
> with TPM if it exists.

If you have a TPM, the current code wouldn't even look for CC (which
we agreed is correct).
The question is, should we care if a firmware exposes the CC protocol,
but isn't virtualized

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> >> https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#confidential-computing
> >>
> >>> Thanks
> >>> /Ilias
> >> --
> >> Sathyanarayanan Kuppuswamy
> >> Linux Kernel Developer
> >>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

