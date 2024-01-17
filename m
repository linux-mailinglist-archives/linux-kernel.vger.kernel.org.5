Return-Path: <linux-kernel+bounces-28931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6C8304C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7451F24BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E21DFD7;
	Wed, 17 Jan 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpoLOPGm"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE81DFC9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492272; cv=none; b=WuzAXfDa05QdEyhepqH2oOeSJ5s9CIH7+1Wf2frSXOskx6RDqxqZOYBUStU/aJ9QS5s76i8BltAQWcm2eGCkldSkJLpI1N/ZrEnlcgOTEBSrl15bQ9HwhUuutMNUVDi3fTF2xCllX+6N5edBSZg150IAKL1PEM4jFRXqCax2xoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492272; c=relaxed/simple;
	bh=OPtTkiouAlCWqpcLmAgIIYVnBKLZUCesR+RlDZ2ERHA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=QLcEztdlQFVnv8ZMN2T37tBcNB0YCM3E6Eqrx9lZWU449tVnzKaasMdvxlMBzULSB8O0WOvj1xlAf6o0SOzhS6LfnI/9ZxHvai1S+RNHnXcvM97f4VnqyaB0SBQ3mwpkUBulI+LtMpfFs7McyS1grsRY+eHyeZf4r9a4xkxxVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpoLOPGm; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0af93fdaaso3053962a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705492270; x=1706097070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXdybsjFtwqNXBEWu9TqcaPjVsWwWYgbT9rFiwsm5no=;
        b=JpoLOPGm4m5YCEANyVIzDcTDaDRQMbzQgUed+lnaAdUWKOQy+FQXnBp2ucAuzYcEVs
         3IdL3hrZbq/iOhDihEqZPSNkfF5XmCEoDoqBtO7mBDFW3WWW3s7GFdDUJFdMiWdy/p/q
         vmALUNaZZXWr/ykYp1725OShu+XaHEyu36u7MusUcVvVirE9WxNVes1g7Zyl45EYqSsC
         Wq/RWfhUhQlCI2vkhp4v48FEJW2PtabX66mwkipDy5iTee4gdwQyc70UMrFxI9Jw0kV1
         9nS0x/cDHbpSai1lHjsZrr4Zq7xsEKbyhZClzRLNOfXsO1edT85zfEawRkUnExMFRNQs
         cIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705492270; x=1706097070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXdybsjFtwqNXBEWu9TqcaPjVsWwWYgbT9rFiwsm5no=;
        b=qJGTTlYotQ/2Jukt22+PhBOnDDrHdGuqoGgnsin70au8Fh/ePYI6j6g8DwwsT6Qp6E
         nui4TG+e3JDFq2fuoKEKe3C2f+Xfg8WL5olBjJbHBVEVe3XgyhmBkbMSUF8bfbVM7Jwv
         p3ow/nRsyxxb0dND9sXiAJMs6IkCjLF9vyWG8WCvGaPIcEuTeF4KQryiFt4Hk+rsLE+w
         ifbGpRnpaMWzDoVXYoxEZky43XxNXnc/DFw0zabYu9An12PcTCv0eaZcUAJbhYHgzf7R
         bGZNjpBI36FPT0oEmKieNDm+6HStbTVycZet2IHo+rQOpU/GpEhSps/RrHM9DbNHHIr8
         KnMg==
X-Gm-Message-State: AOJu0YxaJEd8SVH6KUaH2D4h9ccq9AQKOzXyH8AqcEw/ve+gC2682J4P
	66yux3RccwOoA2E0lie7ty97MnZV4FEToo9lLe2jqQgtOHsX
X-Google-Smtp-Source: AGHT+IG/wDBOkxzJko6OLem/YlrNqdTvdNAUOWJmyU8KZmoB2Kfzv7UhyXfsUX+9Ig0/FfWRcwDnrySmQxh0yZQpmsw=
X-Received: by 2002:a05:6359:4293:b0:175:c21c:87c4 with SMTP id
 kp19-20020a056359429300b00175c21c87c4mr9260102rwb.53.1705492269980; Wed, 17
 Jan 2024 03:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117113806.2584341-1-badhri@google.com>
In-Reply-To: <20240117113806.2584341-1-badhri@google.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Wed, 17 Jan 2024 03:50:33 -0800
Message-ID: <CAPTae5Kt8_sb4as4mwP8vNQJXPFxECdfwkNVY=FW4Sc1Fnf_jg@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "usb: typec: tcpm: fix cc role at port reset"
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Please ignore this patch as I sent a V2 which fixes the commit message.

Thanks,
Badhri


On Wed, Jan 17, 2024 at 3:38=E2=80=AFAM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
>
> Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
> the CC pins, setting CC pins to default state during PORT_RESET
> breaks error recovery.
>
> 4.5.2.2.2.1 ErrorRecovery State Requirements
> The port shall not drive VBUS or VCONN, and shall present a
> high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.
>
> Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
> CC pins are set to default state after tErrorRecovery in
> PORT_RESET_WAIT_OFF.
>
> 4.5.2.2.2.2 Exiting From ErrorRecovery State
> A Sink shall transition to Unattached.SNK after tErrorRecovery.
> A Source shall transition to Unattached.SRC after tErrorRecovery.
>
> Cc: stable@kernel.org
> Fixes: 1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index 5945e3a2b0f7..9d410718eaf4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4876,8 +4876,7 @@ static void run_state_machine(struct tcpm_port *por=
t)
>                 break;
>         case PORT_RESET:
>                 tcpm_reset_port(port);
> -               tcpm_set_cc(port, tcpm_default_state(port) =3D=3D SNK_UNA=
TTACHED ?
> -                           TYPEC_CC_RD : tcpm_rp_cc(port));
> +               tcpm_set_cc(port, TYPEC_CC_OPEN);
>                 tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>                                PD_T_ERROR_RECOVERY);
>                 break;
>
> base-commit: 933bb7b878ddd0f8c094db45551a7daddf806e00
> --
> 2.43.0.429.g432eaa2c6b-goog
>

