Return-Path: <linux-kernel+bounces-63826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA28534F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA7282A20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5555EE77;
	Tue, 13 Feb 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBcRM02X"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15345EE62;
	Tue, 13 Feb 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838871; cv=none; b=QJn5h8rvOkmEjN2aNlVcLEFHV9sEyHf4Mht5pU6crpBNSK5oqXGvEEidIr6ikayv8WPULsjfoz7K8xvU7A2FXJugdsvLS8JMlyjDxiOyZB93tTSMBetfDw5Y/+IKfu8dbI7Pl8KzJWuM5InYKDFmqemiWXrNktioOjB5k7qsucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838871; c=relaxed/simple;
	bh=pmt8LBlGQ72tRLTCtSSKT8KBTn44RMC9sRMvMykqm9w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=qrwPO8zreOB1UtHp3kfSVRz6W15GjKuAv+ML6TnrtGkPTOCI50JXK+NW8s+5f3aAKGk6K2QMh275OoBd8w0Gz6oZ0n8yI4IOfqMPK34KHjY+dplyCtddTx4kN2x1MujV7bO9jt4bwQNlKTiMmyGKz3wrrcgdjZ4wnEQFA4QhC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBcRM02X; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707838869; x=1739374869;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=pmt8LBlGQ72tRLTCtSSKT8KBTn44RMC9sRMvMykqm9w=;
  b=iBcRM02XJ65txIFqK/Jaw+3L3/aBK3H16TgUZkOCdPyqX6D0YNxu53IX
   YZbZX3jhZ9CWHtEswPcvGTUkN/mceIsYmncqS+4OghVO9tNJq8MHmevRd
   dgF+OJqfnfiu+g46U6Q/RAdux8PlfxqShyuV/tw27R/dNkR3NFRl9tziz
   asOuI3jLPRQwNqQED+AtLDs8L2kFcC60Y+wElZ3BGgkMHlpkOvQdB+u8p
   PFKfjZiVT8X6Zse6ldUQ480pcigkMk0wv18vLzTScdP/0S5mq3K8IB39h
   lE5bC4hdRU1pnjTp+qqOB9BXmicocAYtV1Aqt4ld5srVJfK69OsAAH38b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436997103"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="436997103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935370607"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935370607"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 07:41:07 -0800
Message-ID: <a715f138-079c-0d45-6bba-ab88097ae678@linux.intel.com>
Date: Tue, 13 Feb 2024 17:42:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Jan Henrik Weinstock <jan@mwa.re>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Lukas_J=c3=bcnger?= <lukas@mwa.re>
References: <CANi1PHh4W7KPagKkvZW6cNAQqgAeG3zxaaTJKkg3KiTbsFRMdg@mail.gmail.com>
 <1b2558f7-94ea-123e-dd3f-b43ecd85c2ef@linux.intel.com>
 <CANi1PHhY67HZxivA9mCoNXfM4YUOjm=tCZsnhrrcu4E6dqDYUQ@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: XHCI without USB2 ports
In-Reply-To: <CANi1PHhY67HZxivA9mCoNXfM4YUOjm=tCZsnhrrcu4E6dqDYUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Is it so unusual to have an XHCI that has only USB3 ports?

Yes, this is the first one I've heard of.

> 
> My understanding was that a port can either be USB3 or USB2 (assigned
> via the Supported Protocol Capability).

Each USB3 host connector has both a USB3 and USB2 port in the Supported
Protocol Capability.
See xHCI specification 7.2.2.1 "USB Protocols" note:

"Note: To support USB3 device certification requirements for USB2 user attached
  devices, USB 2.0 and USB 3.x Supported Protocol Capabilities shall be declared
  if any USB3 connectors are associated with xHCI Root Hub ports that enable user
  attached devices. Refer to sections 11.1 and 11.3 in the USB3 spec"
> 
> This would mean that in order to work correctly with Linux, all XHCIs
> right now would have to support at least one USB2 port in addition to
> their USB3 ports.

Yes, that is currently the case.
But normally each USB3 connector has a matching USB3 and USB2 port pair.

USB 3.2 specification section 11.1 dictates that:

11.1 USB 3.2 Host Support for USB 2.0
"USB 3.2-capable ports on hosts shall also support USB 2.0 operation in order
  to enable backward compatibility with USB 2.0 devices. It should be noted,
  however, that USB 3.2-capable hosts are not required to support Enhanced
  SuperSpeed operation on all of the ports available on the host, i.e.,
  some USB 3.2-capable hosts may have a mix of USB 2.0-only and USB 3.2-capable
  ports."

(Similar statement exists in older USB 3.0 specification)

xHC with just one USB3 port could maybe be possible in some built in SSIC device
case without user attachable ports, or some setup with several host controllers
where one handles the USB3 traffic and the other the USB2 traffic of the same USB3
connector.

Thanks
Mathias


