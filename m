Return-Path: <linux-kernel+bounces-160615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC58B401E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BC8282233
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F318643;
	Fri, 26 Apr 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IGs4g+0q"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCC1096F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159534; cv=none; b=nDb7an0o38VlPeAERIzSEuxWQV40wtO/w/1AYZ/ElH7q93dpihL61mefapPioYQO6itjPbvUq5d/4GtgOa6hZLKmpRfnXec9dmpwLO4BKwsPqOCFGZ7s3CD0OWA30TGHpKRFGndfh91dcOhfgNASgDcKjAEV2LmaeD1c5GnpaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159534; c=relaxed/simple;
	bh=uC1Utehwjep+6gqRRxnkvKpDqpM6YDguBl7NAqG24QA=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQSCSgYNSZkp2vmub89C5HKQ5epJoog8QD3es/3XtQfXIjbgprBbnhH7+gmV3gAKVNV2xL8GL9GonReHXuVDGgm3vLXCxhX9ayy5hcOjMmJe9VWpu+8l4tv2EvgmFPSK6iAZuyWHPVSyTVpmXUdbu8yyUSfXrSkvEreT+Gv67BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IGs4g+0q; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2348a5d1584so1247675fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714159532; x=1714764332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQxkTywT0oafPa8v7d8P+d2tc0CmNmZnmiS4+g+7FcY=;
        b=IGs4g+0qaPfkd10ZlOjZmCJMRHatO10nsa6vygogrdteauiYIKJ7Gby35OlqFhOeOv
         qii4R43l/+MQcjOqNDGvMWxLftyZm1PB9umdo8BAITKX2PCvpEuXRBuhHxpExg4/o5xh
         72qdrRLj6Jc9+/YRZ6wZZPGrxLvtCDw/s+M1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714159532; x=1714764332;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQxkTywT0oafPa8v7d8P+d2tc0CmNmZnmiS4+g+7FcY=;
        b=ReynMmPhbbTJrSSm7s3WF42ufbApC9NcI78yQYZO8BTekyzcwHX6FxmfubWq7X09oo
         k8qqj0N3XSf4fxSezCPrRtZqXB28/3LsHUXgz88S34+yb6+X1AjGBofohi+qwD1WO3yD
         fL3Zovbd6fKyHWozwuWpP2522Sp3X+YtQ31YHk/MrCAGatYMQnSIRE+mxoFp4SAzzpR0
         Hctw0iNC678Jo+JyBFVXb8aLZgmEn8JjH4L1Bs3IMtjzaoeO4uyhPOCWH8AoSVG658Aa
         PHk15ZawXRTGSL31jank7TVyj2FzaplMRAyJZLM4415ik6rKgtySPnYiTOi8fQ4knMxj
         k4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXblZ6VhDbKktJVvFi5PCR842X863AXC2rzU/HVPUx8iAGfPqNMNlY2Ix0M5HcbXiF5xCLPuSjU9c/NfHTPNLLyC5Ji1wL3gHES1xNG
X-Gm-Message-State: AOJu0YxwtkUno+1gWbeQdvawCO0gM7dr328PB9H3WEXZ73IR0JOZ25II
	Fe1chsz+M+T1TEZ/cU8mGIafwZ0AzhkyiPn98GMMoIEVFUj/GxNjB8BJbWun4C0Bv+L1AjpzNOv
	IcQXhsz9kaCNb0JbRrwvkpYC13I6nSpBTnBxo97wm60diWJtIoJcl/FRMhyVjSK6zbLDACwPY1r
	c42tasZUy1nOurKLFblbNMriN25Q==
X-Google-Smtp-Source: AGHT+IGolhQr3PQiqQRxUyZHK/lDEmlBp55kfr5Ue0BBSt4bXuZMGwMI6aRz/6nhPaa1QsqxYlJltWnW3eQCB73+VBI=
X-Received: by 2002:a05:6870:f21a:b0:222:570a:72c7 with SMTP id
 t26-20020a056870f21a00b00222570a72c7mr4020266oao.45.1714159532067; Fri, 26
 Apr 2024 12:25:32 -0700 (PDT)
From: Harold Johnson <harold.johnson@broadcom.com>
References: <20240321174423.00007e0d@Huawei.com>	<66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
 <20240410124517.000075f2@Huawei.com>	<66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
 <20240425123344.000001a9@Huawei.com>	<662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240425182605.00005f22@Huawei.com>	<662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426094550.00002e37@Huawei.com>	<662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426175341.00002e67@Huawei.com>
In-Reply-To: <20240426175341.00002e67@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKunZEo8R7Jz4kBtk6k2PvotGU0HgHS0NaiAcYBqoMBlEd6hQI3yNWyAXtbGeoCNAHAQgKHImC+AgG1eBACLtCTCwHsMLvJrzUWuSA=
Date: Fri, 26 Apr 2024 14:25:29 -0500
Message-ID: <6351024b5d6206c4e9a8cd98d1a09d43@mail.gmail.com>
Subject: RE: RFC: Restricting userspace interfaces for CXL fabric management
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, 
	Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>, 
	Brett Henning <brett.henning@broadcom.com>, 
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>, linux-kernel@vger.kernel.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com, linux-api@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>, 
	gregkh@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000004f100061704decf"

--00000000000004f100061704decf
Content-Type: text/plain; charset="UTF-8"

Perhaps a bit more color on a few specifics might be helpful.

I think that there will always be a class of vendor specific APIs/Opcodes
that are related to an implementation of a standard instead of the
standard itself.  I've been party to discussion on not creating CXL
defined API/Opcodes that get into the realm of specifying an
implementation.  There are also a class of data that can be collected from
a specific implementation that is helpful for debug, for health
monitoring, and perhaps performance monitoring where the implementation
matters and therefore are not easily abstracted to a standard.

A few examples:
a) Temperature monitoring of a component or internal chip die
temperatures.  Could CXL define a standard OpCode to gather temperatures,
yes it could; but is this really part of CXL?  Then how many temperature
elements and what does each element mean?  This enters into the
implementation and therefore is vendor specific.  Unless the CXL spec
starts to define the implementation, something along the lines of "thou
shall have an average die temperature, rather than specific temperatures
across a die", etc.

b) Error counters, metrics, internal counters, etc.  Could CXL define a
set of common error counters, absolutely.  PCIe has done some of this.
However, a specific implementation may have counters and error reporting
that are meaningful only to a specific design and a specific
implementation rather than a "least common denominator" approach of a
standard body.

c) Performance counters, metric, indicators, etc.  Performance can be very
implementation specific and tweaking performance is likely to be
implementation specific.  Yes, generic and a least common denominator
elements could be created, but are likely to limiting in realizing the
maximum performance of an implementation.

d) Logs, errors and debug information.  In addition to spec defined
logging of CXL topology errors, specific designs will have logs, crash
dumps, debug data that is very specific to a implementation.  There are
likely to be cases where a product that conforms to a specification like
CXL, may have features that don't directly have anything to do with CXL,
but where a standards based management interface can be used to configure,
manage, and collect data for a non-CXL feature.

e) Innovation.  I believe that innovation should be encouraged.  There may
be designs that support CXL, but that also incorporate unique and
innovative features or functions that might service a niche market.  The
AI space is ripe for innovation and perhaps specialized features that may
not make sense for the overall CXL specification.

I think that in most cases Vendor specific opcodes are not used to
circumvent the standards, but are used when the standards group has no
interested in driving into the standard certain features that are clearly
either implementation specific or are vendor specific additions that have
a specific appeal to a select class of customer, but yet are not relevant
to a specific standard.

At the end of the day, customer want products that solve a specific
problem.  Sometimes vendor can address market segments or niches that a
standard group has no interest in supporting.  It can also take months,
and in some cases years to reach an agreement on what standardized feature
should look like.  I also believe that there can be competitive reasons
why there might be a group that wants to slow down a vendor's
implementation for fear of losing market share.

Thanks
Harold Johnson


-----Original Message-----
From: Jonathan Cameron [mailto:Jonathan.Cameron@Huawei.com]
Sent: Friday, April 26, 2024 11:54 AM
To: Dan Williams
Cc: linux-cxl@vger.kernel.org; Sreenivas Bagalkote; Brett Henning; Harold
Johnson; Sumanesh Samanta; linux-kernel@vger.kernel.org; Davidlohr Bueso;
Dave Jiang; Alison Schofield; Vishal Verma; Ira Weiny;
linuxarm@huawei.com; linux-api@vger.kernel.org; Lorenzo Pieralisi; Natu,
Mahesh; gregkh@linuxfoundation.org
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric
management

On Fri, 26 Apr 2024 09:16:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > To give people an incentive to play the standards game we have to
> > provide an alternative.  Userspace libraries will provide some
incentive
> > to standardize if we have enough vendors (we don't today - so they
will
> > do their own libraries), but it is a lot easier to encourage if we
> > exercise control over the interface.
>
> Yes, and I expect you and I are not far off on what can be done
> here.
>
> However, lets cut to a sentiment hanging over this discussion. Referring
> to vendor specific commands:
>
>     "CXL spec has them for a reason and they need to be supported."
>
> ...that is an aggressive "vendor specific first" sentiment that
> generates an aggressive "userspace drivers" reaction, because the best
> way to get around community discussions about what ABI makes sense is
> userspace drivers.
>
> Now, if we can step back to where this discussion started, where typical
> Linux collaboration shines, and where I think you and I are more aligned
> than this thread would indicate, is "vendor specific last". Lets
> carefully consider the vendor specific commands that are candidates to
> be de facto cross vendor semantics if not de jure standards.
>

Agreed. I'd go a little further and say I generally have much more warm
and
fuzzy feelings when what is a vendor defined command (today) maps to more
or less the same bit of code for a proposed standards ECN.

IP rules prevent us commenting on specific proposals, but there will be
things we review quicker and with a lighter touch vs others where we
ask lots of annoying questions about generality of the feature etc.
Given the effort we are putting in on the kernel side we all want CXL
to succeed and will do our best to encourage activities that make that
more likely. There are other standards bodies available... which may
make more sense for some features.

Command interfaces are not a good place to compete and maintain secrecy.
If vendors want to do that, then they don't get the pony of upstream
support. They get to convince distros to do a custom kernel build for
them:
Good luck with that, some of those folk are 'blunt' in their responses to
such requests.

My proposal is we go forward with a bunch of the CXL spec defined commands
to show the 'how' and consider specific proposals for upstream support
of vendor defined commands on a case by case basis (so pretty much
what you say above). Maybe after a few are done we can formalize some
rules of thumb help vendors makes such proposals, though maybe some
will figure out it is a better and longer term solution to do 'standards
first development'.

I think we do need to look at the safety filtering of tunneled
commands but don't see that as a particularly tricky addition -
for the simple non destructive commands at least.

Jonathan

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--00000000000004f100061704decf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
dxEvQsUZzrDYkcbaq0pFKldUHCFlJ40A6mYMamtX+K/dOy8JOPpcsGATQJVvOCowPByerwQ2YA5H
aVoejByKvh4PX1ZKTHd4T0PI04SW0XhQeOY9Q4MrNrzi2GgJAgMBAAGjggHcMIIB2DAOBgNVHQ8B
Af8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYB
BQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCYG
A1UdEQQfMB2BG2hhcm9sZC5qb2huc29uQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcD
BDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUjGUx5P4A0p/XH6QC
1/fEZlOUtrQwDQYJKoZIhvcNAQELBQADggEBAEaE/q6aHZ15f6d2Mm7iGYaGrKrIsNcfY7lr6YYY
aEW1RGXYnu07R4eZBYISoKuJN1qKLBN+Onl1+9L8yKo2YuIH3A22iWBzV06uxFnip75Qeujg+0+r
SH5Mdh6QCregHSSQawF0oHt50q8l5uLY0X/tOe34TxqNigwKJAJ5XE8SnZQauJrCPy5ppMgwJ9JT
hpG/km0i0PgommCbk4Y0nd6Y84hgbte6DmlyDym+4qaHp8UD2rpXQLHDzcUzlY/JsJPAxsPl0mpT
uKUgobEhkpp0ZYEWdB5cndcazW23IHRvnCtBG166CIEknolVYuVVbiY+IKNL8mwVqBrX9jizckox
ggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEw
LwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxWMcpZynHG
JESlG+cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINXOgULaISToEgr9m1csddu3
HPAVkrR3GSPYd3Pz5sY5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTI0MDQyNjE5MjUzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEW
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA/CilH+vbwSUGgfkD8NuYNxxI4IZUBrf5pl6k8SQTg
lNGcVBMcP/gOyjbt+wRzCtaLxjobP5Y+CO2Z4t5VxAcBy3g5Qw0gBxCqcpA9MHcRMO59TZZl6M9V
pNGa9nMNQwmsvyJhavZ1zbwhx1nSh0pBfcuZVWdAdghGR0PbUvgltiFvhrGJSxZKmVsidYSgpvo4
OT6Dj3zKC7jnJfVMRmWSV5JpafYCPfe+Cu9j6NY/tLqkvuA+SULPyfEaG7ViYYyNj7TsuO5VSUO7
2WPQCZohhg+Yw7tkBMVSrc64cOo0I8Rb5161GIO7NQq8EZIbukdDzMAivY4MWVwTy6etC5Jp
--00000000000004f100061704decf--

