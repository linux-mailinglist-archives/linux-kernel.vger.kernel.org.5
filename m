Return-Path: <linux-kernel+bounces-164128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F78B796C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2E1F21033
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864E172BD3;
	Tue, 30 Apr 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWQepjgq"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BC17278D;
	Tue, 30 Apr 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486914; cv=none; b=K12Jfbu0L55DCz/PDIWMpxxH1cM1nBidj9Xq4Z+iqiOdNTqBuGuSZIveAIdXim0N/uBT2JdWvLE0DCeEZa1awyk16RYaL/aWaov0Ue0iRfyYxHaNS9ihB+My1aRxs0m5o0UzrE3vDIgWFJjueENXjH6JIAsWcDyyA6+KrEPG5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486914; c=relaxed/simple;
	bh=aJkTXFdiDDIRnJh37eZO9dtbGQoBiM0P46Smeiszvg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN4JKl6l2nQeRybvCfeBQwr2awPheWOsE6+YvkqV2/Go50Z6zkgED3u9a8kdW+DebrXfi2edZYGj1O9R7Y5g0EixFfOMJwszNcCi7Dh+33bMYGieAU7O8fbXLS+RsDMfVTtaHliQ01gc6koyyNJN6/p+9E53fzOt3OB3+RkFgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWQepjgq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso74850401fa.3;
        Tue, 30 Apr 2024 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714486910; x=1715091710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNLtSQWQ+pUdMr4er7Ppah+nn4cfdZN22MtBKL7h/00=;
        b=RWQepjgqz1lwNDJIfMroam0/6RIqPDizlqaBWoULDESIhCXTcmjt6/38tHbh1F5E8R
         KzQ/5eh1YT9+uoDNc2C1BWG4bXlWnqMhuly1jws385sV+1LwcKWgYKFdrWmxsfy7F7IS
         mwgvTmN6ERyFu5CGPz7Aac0gMXtNVRuag1oPwVU1aIfezUEg2KGEG9MxpY3V1CjscQ5n
         /i2f8BEWUWvajnebHhCqcpBWGRSAW6bhIpHXsTpaMVxr4LgVoUxzSqsC3gkQM1T927Ey
         OUeIWg6OWTGgAjUq01HN+PRNqP5Y1O0kucnUGIC+VW5TfC7sSqkEgZhUM1+X9drY8qbC
         RspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486910; x=1715091710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNLtSQWQ+pUdMr4er7Ppah+nn4cfdZN22MtBKL7h/00=;
        b=Xhk/ZA5alitsH8c3Rg+mn52ywuW93spY/VKcI2pkTeHKduD4oihEDuz9BZ2oVGP/6c
         NCzUlFZxQ8KIg8AKzKX6NstqDoDlIOPLsfTD+FsFDTkNIzKWW4oiYv5yylT17ztBbh6+
         P2/vKhprBZmKHrAuqAs7v5UDggNkbtV+V5WLTF4DWBBmBq4DM/vSFOhUMTB3Hp4gKY2y
         Zn/8l88Q2fgufNwwGUsBBCdRND4p83IjGHDwWP03xu5HNaVNQuDzOL7WIYVGx7bs3qOd
         qRMGs/xY5wCiz/vBENaj3skd6LHpqoKER+SX+qyVcTP8mT000T1XfUPW+8jV5LKKleGu
         MmoA==
X-Forwarded-Encrypted: i=1; AJvYcCVRkeNQl3isA4H3Yjg+mykQA/H3b6fWmAuAGcP3AQ1govUW6aG9Ivv9Nbe9ex3Mi9f5Iv6U9FTxcJWJHxh1IPB1lx+WIMriRPMkKvKPK5SoR7vZR+7Bg8tIM3FZhO2V3xzbMS2GHNvjM86LlklNsTn9IoHSadOFVrcR0II/ktNQ21YlLVjj
X-Gm-Message-State: AOJu0YxrV7a8+4WUCE+dub+d1E/kP/r7dxWInu7UtdHr7Rrv8IiwpuRM
	m85FTfCFBDLJOauvQ8hfjdWL9RhN2WInBMhN+hosQgw9lR2nfgi4Esvj66yJnsh6B/6eOpn14K0
	NwEl6joqfjioHLNgrxmS6YZo1QVM=
X-Google-Smtp-Source: AGHT+IHTCS7gq5KRR3pfsSVkeAJrvhfopA+NEKyyLw2ElLjVgelXnMdwQQOGkXfLsu5N4H4RDfZBLvJ/HCfXzpYbniU=
X-Received: by 2002:a2e:a28f:0:b0:2df:6e6d:2c22 with SMTP id
 k15-20020a2ea28f000000b002df6e6d2c22mr9310394lja.47.1714486910189; Tue, 30
 Apr 2024 07:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com> <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
In-Reply-To: <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Apr 2024 10:21:37 -0400
Message-ID: <CABBYNZ+pPTTOSzb2HpStRo273EPsLYgwMFRPJTaJP9Xk038nwQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Sat, Apr 27, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Fri, Apr 26, 2024 at 10:23:15AM -0700, Doug Anderson wrote:
> > On Fri, Apr 26, 2024 at 9:00=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
> > >
> > > The default device address apparently comes from the NVM configuratio=
n
> > > file and can differ quite a bit.
> > >
> > > Store the default address when parsing the configuration file and use=
 it
> > > to determine whether the controller has been provisioned with an
> > > address.
> > >
> > > This makes sure that devices without a unique address start as
> > > unconfigured unless a valid address has been provided in the devicetr=
ee.
>
> > >  int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_vers=
ion *ver,
> > >                          enum qca_btsoc_type soc_type)
> > >  {
> > > @@ -351,6 +348,11 @@ static void qca_tlv_check_data(struct hci_dev *h=
dev,
> > >
> > >                         /* Update NVM tags as needed */
> > >                         switch (tag_id) {
> > > +                       case EDL_TAG_ID_BD_ADDR:
> > > +                               if (tag_len !=3D sizeof(bdaddr_t))
> > > +                                       break;
> > > +                               memcpy(&config->bdaddr, tlv_nvm->data=
, sizeof(bdaddr_t));
> > > +                               break;
> > >                         case EDL_TAG_ID_HCI:
> >
> > nit: blank line after "break" ?
>
> Possibly, the driver isn't really consistent here and only two case
> statements have such a newline after break.
>
> > Also note that on my firmware I never see this tag and thus your patch
> > breaks trogdor. Specifically I put a printout here and it never gets
> > hit.
>
> Thanks for the quick test. As the parser is modifying the configuration
> file I assumed it was correct and tested...
>
> > I printed all the tags/lengths:
> >
> > [   17.961087] DOUG: id 0xde02, len 0x0010
> > [   17.965081] DOUG: id 0x0000, len 0x0000
> > [   17.969050] DOUG: id 0x0000, len 0x0011
> > [   17.973025] DOUG: id 0x0000, len 0x0a00
> > [   17.976991] DOUG: id 0x0303, len 0x0303
> > [   17.981066] DOUG: id 0x0033, len 0x1001
> >
> > Probably EDL_TAG_ID_BD_ADDR should have been 0xde02, not just 2.
>
> No, the parser is apparently broken and fails to consider an extra
> four-byte header found in some NVM files and just happily parses and
> potentially modifies (sic!) random bytes.
>
> I've fixed the parser so that it works also on configuration files with
> the extra header (apnv??.bin, crnv??[u].bin) and can read out the
> default address for all NVM files in linux-firmware that have one
> (otherwise all-zeroes is printed below):
>
> bluetooth hci0: bd_addr =3D 39:80:10:00:00:20 (qca/apnv10.bin)
> bluetooth hci0: bd_addr =3D 39:80:12:74:08:00 (qca/apnv11.bin)
> bluetooth hci0: bd_addr =3D 39:90:21:64:07:00 (qca/crnv21.bin)
> bluetooth hci0: bd_addr =3D 39:98:00:00:5a:ad (qca/crnv32.bin)
> bluetooth hci0: bd_addr =3D 39:98:00:00:5a:ad (qca/crnv32u.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21.301)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21.302)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21.309)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21g.301)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21g.302)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21g.309)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/hpnv21g.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/htnv20.bin)
> bluetooth hci0: bd_addr =3D 64:90:00:00:5a:ad (qca/msnv11.b09)
> bluetooth hci0: bd_addr =3D 64:90:00:00:5a:ad (qca/msnv11.b0a)
> bluetooth hci0: bd_addr =3D 64:90:00:00:5a:ad (qca/msnv11.bin)
> bluetooth hci0: bd_addr =3D 61:47:aa:31:22:14 (qca/nvm_00130300.bin)
> bluetooth hci0: bd_addr =3D 61:47:aa:32:44:07 (qca/nvm_00130302.bin)
>
> bluetooth hci0: bd_addr =3D 00:00:00:00:00:00 (qca/nvm_00230302.bin)
>
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_00440302.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_00440302_eu.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_00440302_i2s_eu.bi=
n)
>
> bluetooth hci0: bd_addr =3D 00:00:00:00:00:00 (qca/nvm_usb_00000200.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:00:00 (qca/nvm_usb_00000201.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:00:00 (qca/nvm_usb_00000300.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:00:00 (qca/nvm_usb_00000302.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:00:00 (qca/nvm_usb_00000302_eu.bi=
n)
>
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0104.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0105.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0106.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0107.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0109.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0110.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130200.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201_010a.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201_010b.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201_0303.=
bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_01=
0a.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_01=
0b.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_03=
03.bin)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf.bi=
n)
> bluetooth hci0: bd_addr =3D 00:00:00:00:5a:ad (qca/nvm_usb_00190200.bin)
>
> It looks like we're being lucky and the parser is at least not
> corrupting the configuration files with the extra header currently in
> linux-firmware, but if it ever interprets a random 0x0011 or 0x001b word
> as a tag it would.
>
> Fixing the parser means that we would start modifying the configuration
> also for files with the extra header. This involves configuring the baud
> rate and enabling a deep sleep feature.
>
> Presumably this is something that should be done also on Trogdor, but
> this would obviously have to be tested first. I guess we can keep
> skipping this step until it has been verified and just read out the
> address for now.
>
> > > @@ -624,6 +626,9 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
> > >         if (bacmp(&hdev->public_addr, BDADDR_ANY))
> > >                 return 0;
> > >
> > > +       if (!bacmp(&config->bdaddr, BDADDR_ANY))
> > > +               return 0;
> >
> > The above test feels non-obvious enough to deserve a comment. Could
> > you add one? That would also help alleviate my confusion since I
> > _think_ your if test is unneeded and maybe wrong? Let's say that the
> > firmware didn't have a default address stored in it. It still seems
> > like we could try to read the address and then if the firmware gave
> > back BDADDR_ANY (0) we should set the `HCI_QUIRK_USE_BDADDR_PROPERTY`
> > property, right?
>
> You're right. I'll drop this check when revisiting this next week.

I assume you will spin another version then?

--=20
Luiz Augusto von Dentz

