Return-Path: <linux-kernel+bounces-54098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5C84AAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A97628445F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA14A99C;
	Mon,  5 Feb 2024 23:38:19 +0000 (UTC)
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F11482F7;
	Mon,  5 Feb 2024 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176299; cv=none; b=dZ0iJdy6HsHY6NDy4QGpxnxkmGxkgEuzywAOqRFwZpRTFEyfqDAv5J1w+IhyNYbqrPxI2jQqQjVUS7Pxh4VFe3ug8/91/Zc0ahEId1NfI9jQMVInSwV8RDlpdmew7VXyxDcN5a4aND0/r7LPYT1zQCnVmtis/rv1LP2GSWOy+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176299; c=relaxed/simple;
	bh=XUlurPihM1W1ip8i6yn8EbeGzcvMrcvb13sOn4XTwLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUJL97hDQUhH6jM0BsfDo2hbr3oc/Mn+9vizHMawkSwpd4MH93uGhTXJ8XiPgU9+2NQC/Kdkikke9Wbkl2d02RlznENLZEnXgTH8qLEFac2fCJBQeDwmUJiMZ+Ypl5c8XSLTHmfxc5z7S3cZvTm+YFlKxSYLZxz7rNODDCW8ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 415Nb9uK002283
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 6 Feb 2024 10:07:12 +1030
Date: Tue, 6 Feb 2024 10:07:09 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Szilard Fabian <szfabian@bluemarch.art>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [RFC PATCH v2] platform/x86/fujitsu-laptop: Add battery charge
 control support
Message-ID: <ZcFxJf6YqjMAAOou@marvin.atrad.com.au>
References: <20240129163502.161409-2-szfabian@bluemarch.art>
 <20240129175714.164326-2-szfabian@bluemarch.art>
 <fabf391c-933c-4a7b-a23c-d361ad3d7cc0@gmx.de>
 <Zb2GMCSIz1MuWpQZ@N>
 <df011292-48cd-4fbb-856c-20a3db9f99e8@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df011292-48cd-4fbb-856c-20a3db9f99e8@gmx.de>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Mon, Feb 05, 2024 at 06:07:46PM +0100, Armin Wolf wrote:
> Am 03.02.24 um 01:17 schrieb Szilard Fabian:
> 
> > Hello,
> > 
> > On Tue, Jan 30, 2024 at 03:02:09AM +0100, Armin Wolf wrote:
> > > Am 29.01.24 um 19:00 schrieb Szilard Fabian:
> > > > +
> > > > +	return sprintf(buf, "%d\n", status);
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RW(charge_control_end_threshold);
> > > > +
> > > > +/* ACPI battery hook */
> > > > +
> > > > +static int fujitsu_battery_add(struct power_supply *battery,
> > > > +			       struct acpi_battery_hook *hook)
> > > > +{
> > > > +	/* Check if there is an existing FUJ02E3 ACPI device. */
> > > > +	if (fext == NULL)
> > > > +		return -ENODEV;
> > > Can you put the struct acpi_battery_hook into the struct fujitsu_laptop
> > > and then use container_of() to retrieve the ACPI device from there?
> > > The dell-wmi-ddv driver does something similar.
> > > 
> > > This would guarantee that the battery hook always accesses the correct ACPI device
> > > and you could drop this check.
> > > 
> > > > +
> > > > +	/*
> > > > +	 * Check if the S006 0x21 method exists by trying to get the current
> > > > +	 * battery charge limit.
> > > > +	 */
> > > > +	int s006_cc_return;
> > > > +	s006_cc_return = call_fext_func(fext, FUNC_S006_METHOD,
> > > > +					CHARGE_CONTROL_RW, 0x21, 0x0);
> > > > +	if (s006_cc_return == UNSUPPORTED_CMD)
> > > > +		return -ENODEV;
> > > Maybe this check should be done once during probe?
> > What about the following scenario?
> > - Put a bool into the struct fujitsu_laptop to store information about the
> >    machine's charge control ability.
> > - The S006 0x21 method check with `battery_hook_register` gets moved into
> >    an 'init function'. In that 'init function' the bool gets set accordingly.
> > - `battery_hook_unregister` gets moved into an 'exit function', where the
> >    bool gets read and when it's false nothing happens.
> > - `fext` check gets removed from `fujitsu_battery_add` because it's
> >    redundant (more about that later).
> > - The 'init function' gets called in `acpi_fujitsu_laptop_add` and the 'exit
> >    function' gets called in `acpi_fujitsu_laptop_remove`.
> > 
> > With that scenario the code could be a little bit clearer in my opinion.
> > And it is possible to drop the `fext` check because if the FUJ02E3 ACPI
> > device exists `fext` gets set in the `acpi_fujitsu_laptop_add` function with
> > an error check.
> > (And the `fujitsu_battery_add` `fext` check was already redundant because
> > `battery_hook_register` got called in `acpi_fujitsu_laptop_add`. `fext`
> > gets set in the same function, and there is an error check already.)
> > 
> > Thanks,
> > Szilard
> > 
> This would work too.

I'm happy to see this work proceed.  Once a revised patch is available I'll
test it on my S7020.  This should exercise the error recovery code because
the functionality being addressed here almost certainly doesn't exist in a
laptop as old as the S7020.  Yes, my S7020 is still operational and in use.

Regards
  jonathan

