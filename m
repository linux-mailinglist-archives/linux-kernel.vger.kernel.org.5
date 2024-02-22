Return-Path: <linux-kernel+bounces-76826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9E85FD35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E811C2545B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083B152DF4;
	Thu, 22 Feb 2024 15:55:01 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A03150998;
	Thu, 22 Feb 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617300; cv=none; b=UzpS+5BWOFXbq+j/oIP0UfVomSeadJr4VAuIZiNwIXk8jVPAfLTIcAvinqteid9QllUBx/DZS0hYXMLLh4OuTOul1f+yjsMCkPMF/JHHN/8BLNtL0xtk/SLCXPHbiCI14mH/iLuglkr5NJtrZDWNJjSxhX+3Yft1idL7ZORTZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617300; c=relaxed/simple;
	bh=gluI6aLWg3nMLpFfEKPO6lsypiaxhhT0+Fr929aqaTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRD3UOv3GxFG6uaHx8jho49sGmYVIv3HegFEYntOT9Ao1zetfQsZjdB9kfUAefFNl+2+Nt0OrP7ziIs18xP+YNweY40MKVXrKuvfhrXdSbd5zFlatVBr5Ew6/BvLgyT0i39mDRCm3VTLOx4MrT9L4H/FADI9Yyp2YiSAKgT1emM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 097AD2800B1CD;
	Thu, 22 Feb 2024 16:45:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ECB1B53E15B; Thu, 22 Feb 2024 16:45:29 +0100 (CET)
Date: Thu, 22 Feb 2024 16:45:29 +0100
From: Lukas Wunner <lukas@wunner.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dan Middleton <dan.middleton@linux.intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Message-ID: <20240222154529.GA9465@wunner.de>
References: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi James,

On Wed, Feb 07, 2024 at 04:46:36PM -0500, James Bottomley wrote:
> Just to correct this: IMA uses its own log format, but I think this was
> a mistake long ago and the new log should use TCG2 format so all the
> tools know how to parse it.

At last year's Plumbers BoF on PCI device authentication & encryption,
you requested that the kernel exposes proof of SPDM signature validation
so that user space can verify after the fact that the kernel did
everything correctly.

Your above comment seems to indicate that you prefer TCG2 CEL as the
format to expose the information, however the format seems ill-suited
for the purpose:

Per TCG PFP v1.06r52 sec 3.3.7, an SPDM CHALLENGE event merely logs
the nonce used.  That's not sufficient to verify the signature:
The signature is computed over a hash of the concatenation of all
the messages exchanged with the device:

* GET_VERSION request + VERSION response
* GET_CAPABILITIES request + CAPABILITIES response
* NEGOTIATE_ALGORITHMS request + ALGORITHMS response
* GET_DIGESTS request + DIGESTS response
* GET_CERTIFICATE request + CERTIFICATE response (can be multiple)
* CHALLENGE request + CHALLENGE_AUTH response

The content of those SPDM messages is not necessarily static:
E.g. the SPDM requester (the kernel) presents all supported algorithms
and the SPDM responder (the device) selects one of them.

If only the nonce is saved in the log, the verifier in user space would
need to know exactly which algorithms were supported by the SPDM requester
at the time the request was sent (could since have changed through a
kernel update).  It also needs to know exactly which algorithm the
SPDM responder picked.

Armed with the knowledge which algorithm bits were set, the verifier
would have to reconstruct the messages that were exchanged between
SPDM requester and responder so that it can calculate the hash over
their concatenation and verify the signature.

The algorithm selection is but one example of bits that can vary between
different requesters/responders and between different points in time.
The SPDM protocol allows a great deal of flexibility/agility here.

The nonces sent by requester and responder are not the only bits that are
variable, is what I'm trying to say.  Storing the nonces in the log is
sufficient to prove their freshness, but it is not sufficient to prove
correct validation of the signature.

I'd have to store the full concatenation of all exchanged SPDM messages
in the log to facilitate that.  Personally I have no problem doing so,
but it won't be possible with the CEL format as currently specified by TCG.

So on the one hand I'd like to fulfil your Plumbers request to expose
proof of correct signature validation and on the other hand you're
requesting CEL format which is insufficient to fulfil the request.
I don't really know how to reconcile that.

I do see value in exposing the full concatenation of all exchanged
SPDM messages:  It would allow piping that into wireshark or tshark
to decode the messages into human-readable form, which might be useful
for debugging SPDM communication with the device.

In fact, an SPDM dissector for wireshark already exists, though it's
not up-to-date (last change 3 years ago) and probably needs a cleanup
before it can be upstreamed:  https://github.com/jyao1/wireshark-spdm/

I'm considering adding a custom sysfs interface which exposes the last,
say, 64 SPDM events of each device, comprising:

* type of event (CHALLENGE or GET_MEASUREMENTS)
* timestamp
* all exchanged messages
* hash of all exchanged messages
* hash algorithm used
* signature received from device
* certificate chain used for signature validation

The memory consumption for all that data would be significant and the
format wouldn't be TCG2 CEL, but it would fulfil your request to provide
proof of signature verification.

Thoughts?

Thanks,

Lukas

