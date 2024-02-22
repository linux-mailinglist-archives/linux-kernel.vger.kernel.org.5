Return-Path: <linux-kernel+bounces-76352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDE85F5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED342852C9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36B3FB32;
	Thu, 22 Feb 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCJuoWsX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F23F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598772; cv=none; b=gHl4ZabMv/akgWjizSCRoabh21Y9PFgS25SV+g8IoahmXyJ7ZL0wg9jw40Evm/Z7/0/ndZFbJNCoPApzoXhR1bdrudTvGRALUaFcu4SY7AVj2xPL+NjPrODDbMslhsrcusFDgxdMpvmGBnTH0wm7ea06E8lD/S8oEwio8YpiSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598772; c=relaxed/simple;
	bh=WaHYs3tDNZ/6FRp6sSZMOkSoxLkY4gIfyGD/mvLGRxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUERcHM8lgeGtsELU1k8dN35eCp2Aupd0YAquTILFzvzRrLqPuesioWoi/0IdrFEGJyH9sbpqVEMF9y7hLtGpbDSJNM+tmkGSG0DOKeYl9cL2Chyq92jfhLJyYgJmA2aNeVoTgRv8UQnZ44mR+3/Uy2SsYs6xz44u3G9q6hes70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCJuoWsX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708598767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRPR8AvutOPFFWYPFI0BFk7mX8osS7DuA7SiNt9M+vA=;
	b=fCJuoWsXHEIrUln+yD51r8zYAsK+r40Ge5ZGp4ms59CUEkcCntx3JFHNuoPCpGqP4P2yaF
	ZiQmixcxJczWzyBzXQprHg843E7NHWTs4PTlv7fQd9SN3b1ZsbgIitix+NNQX3uYkcD+dN
	9ywrGK56i18+BdwciOP/v9UTyWzPltQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-JLszqSuuOaSZMrNRO0bgRg-1; Thu, 22 Feb 2024 05:46:05 -0500
X-MC-Unique: JLszqSuuOaSZMrNRO0bgRg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3158fbb375so378418866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598765; x=1709203565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRPR8AvutOPFFWYPFI0BFk7mX8osS7DuA7SiNt9M+vA=;
        b=l9Z80XTj0nw7kUC7f8qlaznIU4R9gjsqd7LwRcc+Kdv8otN2w+tv2B3Nyufm6Qk7Vy
         TzUoxynqVTxfGXnRBh4+4pCnP05MEdvEcVhB6bpM73QqELsZGEwNgKkFBJWiTH02Mlbt
         TX5Tcofy2+4ZEkhqqiWxsZPIsZuKmZImF3bL0hsPoDY6cmplIj6Fn9lnMJ0y0kaxeGFT
         cIXPADWrlcP7PiJKqvuahDLIZmtN/51oZgAwddGTO7geJeIgmvJN6p1lghH/38eBKBOL
         87XEadoMTmaRg+Ei5lUma1AAZxQKG7J0aCggtlY3x8yfIE1co8ZjboE7dpzZ8QV17pG1
         kXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJKn+zW1AoEEkHerQ6mzi9Dlug+vrIpTdT9ShA6oBhj0QNgD1wAjJ7u4xpNzRsDgn2pBu3O9FTCgz8DbW7w9yDcvKoXY8+qndOv7/s
X-Gm-Message-State: AOJu0Yz37ib9mL15U29EblxTyqi5k7+UeNB10xxN9pVe9AnMmPho24Ak
	yoPu7KsoEa1d/JCNvAGEM7lSR4IElZWOQ+Lg7BS7X64CjsixhwIVnXfO7WS7ZRFdmxo2jmLtugB
	2HFwanXSFsWKnusbljNLeFfIuP7QgcnfUEkOXEsgL9Hk37qtSQ/3g5Aumx7ue6Q==
X-Received: by 2002:a17:906:4e97:b0:a3f:7fac:6ad2 with SMTP id v23-20020a1709064e9700b00a3f7fac6ad2mr957878eju.52.1708598764831;
        Thu, 22 Feb 2024 02:46:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXxoBT+ZeY1acRDGAGZfFRUc+WAMjs5U2qUzzkSwUQrrqCnfDJdHUdJj930KHBJgZvV563bw==
X-Received: by 2002:a17:906:4e97:b0:a3f:7fac:6ad2 with SMTP id v23-20020a1709064e9700b00a3f7fac6ad2mr957856eju.52.1708598764441;
        Thu, 22 Feb 2024 02:46:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ov28-20020a170906fc1c00b00a3cf9b832eesm5810587ejb.40.2024.02.22.02.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:46:04 -0800 (PST)
Message-ID: <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
Date: Thu, 22 Feb 2024 11:46:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future handling of complex RGB devices on Linux v2
To: Pavel Machek <pavel@ucw.cz>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/21/24 23:17, Pavel Machek wrote:
> Hi!
> 
>> so after more feedback from the OpenRGB maintainers I came up with an even
>> more generic proposal:
>> https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916#note_1753072869
> 
>>> evaluate-set-command ioctl taking:
>>> {
>>>     enum command                /* one of supported_commands */
>>>     union data
>>>     {
>>>         char raw[3072],
>>>         {
>>>             <input struct for command 0>
>>>         },
> 
> Yeah, so ... this is not a interface. This is a backdoor to pass
> arbitrary data. That's not going to fly.

Pavel, Note the data will be interpreted by a kernel driver and
not passed directly to the hw.

With that said I tend to agree that this seems to be a bit too
generic.

Werner, it seems you are basically re-inventing ioctls here.

If you are going to use per vendor specific data structs for various
commands and have those defined in the kernel userspace API headers,
then this means that userspace will already need updated versions
of those headers to support new vendors / new laptop models if
the commands change for a new model.

So what you are basically providing here is a generic interface
to pass a cmd number + a cmd-bumber-specific data struct and
we already have that it is called an ioctl.

So I think that the conclusion of this whole discussion is that
with the exception of a get-dev-info ioctl, we simply want
vendor specific ioctls, using 1 ioctl per command.

Given that these devices are all different in various ways
and that we only want this for devices which cannot be accessed
from userspace directly (so a limit set of devices) I really
think that just doing custom ioctls per vendor is best.

This certainly is the most KISS approach. This proposal
in essence is just an arbitrary command multiplexer /
demultiplexer and ioctls already are exactly that.

With the added advantage of being able to directly use
pass the vendor-cmd-specific struct to the ioctl instead
of having to first embed it in some other struct.

Regards,

Hans




