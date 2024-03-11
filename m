Return-Path: <linux-kernel+bounces-99483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E320878912
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD761281C42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEC55C35;
	Mon, 11 Mar 2024 19:43:52 +0000 (UTC)
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.18.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15B56B63;
	Mon, 11 Mar 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.18.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186231; cv=none; b=ipF1ZaxPLyFJDbGAvYno43UfZcUF1Ivvt6BoIpqN+nASART87uelXig1yEaHXKCkT5LnXEmzrqQgn6K6NMcfWLzZ4HuhqDJkUgJ0g8gY8nxxc0/9SHNJ1E2C0MqTMEc5XmiHUkjpdo7BaUMUfb9VCVfhprE54ylN9aA543qMBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186231; c=relaxed/simple;
	bh=KKQyo51bc/AIZ0093isHt1glyMS5E+CYMY5cLg6WvrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ib8JcMCEUKawlCBM8GB3Dh2MLBGtjyP9QYKFXolaI1tr+ttWHASvUmC51uC9s37UAFhW3ThDavSWtS15a6ygsZNU2W56xMYhyTueZkaOSczcOXaQqI6qZGik5yN79Zz+UKtq8xaXOLiIeFC251/A/xDlhG2Z1WWWhHQnmDDw/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu; spf=pass smtp.mailfrom=apitzsch.eu; arc=none smtp.client-ip=80.67.18.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apitzsch.eu
Received: from [92.206.191.65] (helo=note-book.lan)
	by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <git@apitzsch.eu>)
	id 1rjkh9-000000002Z2-1Jfe;
	Mon, 11 Mar 2024 19:48:19 +0100
Message-ID: <a6d43f8cad8323ab59f44a2c7b0fd5a35cbc86d0.camel@apitzsch.eu>
Subject: Re: [PATCH v4 2/2] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
From: =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-kernel@vger.kernel.org
Date: Mon, 11 Mar 2024 19:48:17 +0100
In-Reply-To: <20240306025801.8814-3-hpa@redhat.com>
References: <20240306025801.8814-1-hpa@redhat.com>
	 <20240306025801.8814-3-hpa@redhat.com>
Autocrypt: addr=git@apitzsch.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=

Am Mittwoch, dem 06.03.2024 um 10:58 +0800 schrieb Kate Hsuan:
> This LED controller also installed on a Xiaomi pad2 and it is a x86
> platform. The original driver is based on device tree and can't be
> used for this ACPI based system. This patch migrated the driver to
> use fwnode to access the properties. Moreover, the fwnode API
> supports device tree so this work won't effect the original
> implementations.
>=20
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

Tested-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu> # on BQ Aquaris M5

