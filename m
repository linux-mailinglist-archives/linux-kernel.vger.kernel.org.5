Return-Path: <linux-kernel+bounces-70782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4576F859C53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCEB1F230F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1A2030F;
	Mon, 19 Feb 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQyCmtoO"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EC200B7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324743; cv=none; b=i+xzlcNedn9pUJ4ITT2OVc1PZgnrjQZJH+3kxk4yPKW/nld+0E7m4wbVsUkIEnvAuUolm/aO/T1R3gJ6k3Yld9W0miz9veg8Tl7wLCcQXb79Ws/nBRzv8WBKIkPQTzOVVzd4ZKcP64pGkO0niTW//Wx4fWoj2TubosQqSED14Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324743; c=relaxed/simple;
	bh=bn22hAbVRAIpE6N8x32GU+BqOXbisrxuCrqfTD+hjW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itDcl9V0RwGaKSBXBbAzaE4TArUfSVmAYCR9LJGab/87TuuI3ZprsguR/mvjCGvOLFNyXo4p8xnvOH8KTdL3VWRhJGKGNfRjdWSPKGzvjOR/3U7aN8kYpbxjJy61T605SzISV/HuoHvu3v7sea3+gIbI5fH5YtUSvn6NDG8ZQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQyCmtoO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso33245801fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708324740; x=1708929540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMM4OlN27SHOCtOj5ufL8MjJjCh3VwYmsX9AUeuZ5U4=;
        b=gQyCmtoOj8tMDd6uBKFzWz97HB/rN6O5WHsGa+wKVKZPmSw0kWL613tE1TYlR5pVD8
         4fcbJ9njaugmntjUB0pVEjUYlSg6cyOHkkC9c0ec7qNNPFGfgNh822N+jT5Gl//9toqa
         /9QWGvbBvZtTbNQiX+cxLhdXxoS9RivUr0qS6DbFERhUMqGGO+O2FPmyziOzu4X2YSK3
         mTw+TTFpYQppPg+uTY52nDG1g9o5NYqWX9bEg/Pjvx4fsxXZea/sjoaXQqqyih4pyAbJ
         ajMbTNh52BTMqSeDGtt+bQ+S2q/SeWPsx59jwT44yYUNzxSQDfjy8qcIZ7h2Og0kguF/
         7lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708324740; x=1708929540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMM4OlN27SHOCtOj5ufL8MjJjCh3VwYmsX9AUeuZ5U4=;
        b=dIVwdGwnaj7B/IFhque3rGrJJ3GRQaDPujgBkNoxPG1Av7tZdbTJ58yQiMHS9u3x9X
         FrV0YEyBw54twAxBjyFmOom6jqyFOHvH07k+ME1nFMzPOJMoFpBvXRZqe46PO/zbqCer
         yC7rNnJbiHkmcwmUy91qZj1qQzQPfqW2T+DE6PstlygFnPEyVz/C05Yo5d0UDyLBRMAy
         3qrPDUdTXEUAw6Cf07fipc8+2P1MB6C80YOZ9l1gJ/9X9ueCCeohK1JFdF4u2KaL9b+C
         0BBHGnp1XxArYzZ2QtQR9RjIEdi4dZfbcZL+2wjYVMMy+E0jrZ/QDzd5bSi+iU+wZ2pa
         MdfA==
X-Forwarded-Encrypted: i=1; AJvYcCUGVoKG8k4PbpaHfMWtWtZSW9WEqrhkL3qKJsm1f45QKTmhqF28Tmqkz4ReIM64339tcDwPBPOJLkhA7KTjG7Yssn+ByAlElEbSMqKz
X-Gm-Message-State: AOJu0Yy02ckPTlRaLToKGcArGGPed8pcyPK/EiQxlex2J39CVp54ASS4
	mhC85aP7OCphHSrvBRqElMPRXuqcTQXrlvvrnN3nK7qondV8MOaPY09EBi8PJCbBJwcYT9p8/T3
	CF0RB4n279OQ1FFZ2keBLzJtLOerAfKnvwS+fYA==
X-Google-Smtp-Source: AGHT+IE5Do2svm3Bso8AFpKefeHNR3iobQSGjsn3Q7K6d+P0nUhURXoXaDzDuPC/MY1/rORrSxIcKc2iipnGq1XhrYY=
X-Received: by 2002:a19:7407:0:b0:512:9e9f:2f1d with SMTP id
 v7-20020a197407000000b005129e9f2f1dmr3700842lfe.58.1708324739383; Sun, 18 Feb
 2024 22:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240215030002.281456-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 Feb 2024 08:38:23 +0200
Message-ID: <CAC_iWj+p6gmcb4-_-f8Kr4Ds6EmSsq2D4GK1XymyybX7i1TMFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/libstub: Add Confidential Computing (CC)
 measurement support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kuppuswamy,

On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> If the virtual firmware implements TPM support, TCG2 protocol will be
> used for kernel measurements and event logging support. But in CC
> environment, not all platforms support or enable the TPM feature. UEFI
> specification [1] exposes protocol and interfaces used for kernel
> measurements in CC platforms without TPM support.
>
> Currently, the efi-stub only supports the kernel related measurements
> for the platform that supports TCG2 protocol. So, extend it add
> CC measurement protocol (EFI_CC_MEASUREMENT_PROTOCOL) and event logging
> support. Event logging format in the CC environment is the same as
> TCG2.
>
> More details about the EFI CC measurements and logging can be found
> in [1].
>
> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>
> Changes since v1:
> * Fixed missing tagged event data.
>
>  .../firmware/efi/libstub/efi-stub-helper.c    | 127 ++++++++++++++----
>  drivers/firmware/efi/libstub/efistub.h        |  74 ++++++++++
>  include/linux/efi.h                           |   1 +
>  3 files changed, 174 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index bfa30625f5d0..cc31f8143190 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -219,50 +219,121 @@ static const struct {
>         },
>  };
>
> +static efi_status_t tcg2_efi_measure(efi_tcg2_protocol_t *tcg2,
> +                                    unsigned long load_addr,
> +                                    unsigned long load_size,
> +                                    enum efistub_event event)
> +{
> +       struct efi_measured_event {
> +               efi_tcg2_event_t        event_data;
> +               efi_tcg2_tagged_event_t tagged_event;
> +               u8                      tagged_event_data[];
> +       } *evt;
> +       int size = sizeof(*evt) + events[event].event_data_len;

This is defined as size_t on the cc variant. I guess both are ok, just pick one

> +       efi_status_t status;
> +
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> +                            (void **)&evt);
> +       if (status != EFI_SUCCESS)

pr_err() here as done in the cc variant?

> +               return status;
> +
> +       evt->event_data = (struct efi_tcg2_event){
> +               .event_size                     = size,
> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> +               .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> +               .event_header.pcr_index         = events[event].pcr_index,
> +               .event_header.event_type        = EV_EVENT_TAG,
> +       };
> +
> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
> +               .tagged_event_id                = events[event].event_id,
> +               .tagged_event_data_size         = events[event].event_data_len,
> +       };
> +
> +       memcpy(evt->tagged_event_data, events[event].event_data,
> +              events[event].event_data_len);
> +
> +       status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> +                               load_addr, load_size, &evt->event_data);

The struct filling/memcpying looks similar across the 2 functions.  I
wonder if it makes sense to have a common function for that, with an
argument for the event data type.

> +       efi_bs_call(free_pool, evt);
> +
> +       return status;
> +}
> +
> +static efi_status_t cc_efi_measure(efi_cc_protocol_t *cc,
> +                                  unsigned long load_addr,
> +                                  unsigned long load_size,
> +                                  enum efistub_event event)
> +{
> +       struct efi_measured_event {
> +               efi_cc_event_t  event_data;
> +               efi_tcg2_tagged_event_t tagged_event;
> +               u8                      tagged_event_data[];
> +       } *evt;
> +       size_t size = sizeof(*evt) + events[event].event_data_len;
> +       efi_cc_mr_index_t mr;
> +       efi_status_t status;
> +
> +       status = efi_call_proto(cc, map_pcr_to_mr_index, events[event].pcr_index, &mr);
> +       if (status != EFI_SUCCESS) {
> +               efi_err("CC_MEASURE: PCR to MR mapping failed\n");
> +               return status;
> +       }
> +
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
> +       if (status != EFI_SUCCESS) {
> +               efi_err("CC_MEASURE: Allocating event struct failed\n");
> +               return status;
> +       }
> +
> +       evt->event_data = (struct efi_cc_event){
> +               .event_size                     = size,
> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> +               .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
> +               .event_header.mr_index          = mr,
> +               .event_header.event_type        = EV_EVENT_TAG,
> +       };
> +
> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
> +               .tagged_event_id                = events[event].event_id,
> +               .tagged_event_data_size         = events[event].event_data_len,
> +       };
> +
> +       memcpy(evt->tagged_event_data, events[event].event_data,
> +              events[event].event_data_len);
> +
> +       status = efi_call_proto(cc, hash_log_extend_event, 0,
> +                               load_addr, load_size, &evt->event_data);
> +
> +       efi_bs_call(free_pool, evt);
> +
> +       return status;
> +}
>  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>                                              unsigned long load_size,
>                                              enum efistub_event event)
>  {
>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> +       efi_cc_protocol_t *cc = NULL;
>         efi_tcg2_protocol_t *tcg2 = NULL;
>         efi_status_t status;
>
>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>         if (tcg2) {
> -               struct efi_measured_event {
> -                       efi_tcg2_event_t        event_data;
> -                       efi_tcg2_tagged_event_t tagged_event;
> -                       u8                      tagged_event_data[];
> -               } *evt;
> -               int size = sizeof(*evt) + events[event].event_data_len;
> -
> -               status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> -                                    (void **)&evt);
> +               status = tcg2_efi_measure(tcg2, load_addr, load_size, event);
>                 if (status != EFI_SUCCESS)
>                         goto fail;
>
> -               evt->event_data = (struct efi_tcg2_event){
> -                       .event_size                     = size,
> -                       .event_header.header_size       = sizeof(evt->event_data.event_header),
> -                       .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> -                       .event_header.pcr_index         = events[event].pcr_index,
> -                       .event_header.event_type        = EV_EVENT_TAG,
> -               };
> -
> -               evt->tagged_event = (struct efi_tcg2_tagged_event){
> -                       .tagged_event_id                = events[event].event_id,
> -                       .tagged_event_data_size         = events[event].event_data_len,
> -               };
> -
> -               memcpy(evt->tagged_event_data, events[event].event_data,
> -                      events[event].event_data_len);
> -
> -               status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> -                                       load_addr, load_size, &evt->event_data);
> -               efi_bs_call(free_pool, evt);
> +               return EFI_SUCCESS;
> +       }
>
> +       efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
> +       if (cc) {
> +               status = cc_efi_measure(cc, load_addr, load_size, event);
>                 if (status != EFI_SUCCESS)
>                         goto fail;
> +
>                 return EFI_SUCCESS;
>         }
>

[...]

Thanks
/Ilias

