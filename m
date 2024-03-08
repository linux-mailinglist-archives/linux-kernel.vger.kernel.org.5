Return-Path: <linux-kernel+bounces-97007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2C87645D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E641F22209
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B8118EAB;
	Fri,  8 Mar 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/ch8c3j"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99A817;
	Fri,  8 Mar 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901220; cv=none; b=f++HJKTJL2zPpBR22r2nZRTh8titHZeWc4ARfejbr/nMXQ6lqEq5Y27P+n4auLfd5wWjk7csboMOTskBc/W/6gzCVg2inbtCo1qKGH5gbOUAd9Rh5iuq4otmQN7LuuyRiuHocTStQ/XiOf8LjK/HqEdvjDl003VB1dHw+3O3rkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901220; c=relaxed/simple;
	bh=/ef0cTS38lWM5VQoqXtXY6cdKzYMyrYFXnzah2yRMu8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqsMQFMDwbrZxXaLqLdJNf1/4mo7vJ1cysxFhulNeX/GrRnYPiKM+F86bwdPTYyF0jT5zHmz7J/I25LCRt5IbmL5X+QNG+/DJqN6WSk4nD/Mcb1nSQyU42OGXZGmo0mtkfDL9i5LtReeCQitjqyKmZ0YzYIo+PHOvydd6blVnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/ch8c3j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/ef0cTS38lWM5VQoqXtXY6cdKzYMyrYFXnzah2yRMu8=; b=s/ch8c3jYkMP02ZxB03PDKfhPw
	Y8yR4+ryExRYPxoVdfZJWUGQVwgz8S/tbSWZNqmUQweMj1b+TxF7VDMczf9Iv92iOzJKGi1cXzg9i
	jir0yINVvbSe2LgYGjWTs5uuy6tuyxICpSs+N0L/JW6nBt4w2sGh2nEmkJ+s2nd8/20L/7xSf17vz
	03Div0Vd8CHiSSw48oJiEIYgOKqq/Z1vu/YYR4UW1DQ36K4RuoLGH6L00Pf7mEvufIM0G+zLCzTJh
	UuY852jZE3RFsiqw/bBfNoujhGNx4nrxhBq/D+0hhvhitO1ATilCm3VI53DyPx3rbOKQRZSSYBWto
	jBZ2q8ZA==;
Received: from [2001:8b0:10b:5:c6ce:88bc:1e6a:da42] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riZPd-0000000BUmL-3Odp;
	Fri, 08 Mar 2024 12:33:24 +0000
Message-ID: <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org,  virtualization@lists.linux.dev,
 virtio-dev@lists.oasis-open.org,  linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org,  "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>
Cc: "Christopher S. Hall" <christopher.s.hall@intel.com>, Jason Wang
 <jasowang@redhat.com>, John Stultz <jstultz@google.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Richard Cochran
 <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc
 Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Alessandro Zummo
 <a.zummo@towertech.it>,  Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "Ridoux, Julien" <ridouxj@amazon.com>
Date: Fri, 08 Mar 2024 12:33:20 +0000
In-Reply-To: <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
	 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
	 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-/Vg2r2b0Ohk48lHKnk9t"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-/Vg2r2b0Ohk48lHKnk9t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-03-08 at 11:32 +0100, Peter Hilber wrote:
> On 07.03.24 15:02, David Woodhouse wrote:
> > On Mon, 2023-12-18 at 08:38 +0100, Peter Hilber wrote:
> > > RFC v3 updates
> > > --------------
> > >=20
> > > This series implements a driver for a virtio-rtc device conforming to=
 spec
> > > RFC v3 [1]. It now includes an RTC class driver with alarm, in additi=
on to
> > > the PTP clock driver already present before.
> > >=20
> > > This patch series depends on the patch series "treewide: Use clocksou=
rce id
> > > for get_device_system_crosststamp()" [3]. Pull [4] to get the combine=
d
> > > series on top of mainline.
> > >=20
> > > Overview
> > > --------
> > >=20
> > > This patch series adds the virtio_rtc module, and related bugfixes. T=
he
> > > virtio_rtc module implements a driver compatible with the proposed Vi=
rtio
> > > RTC device specification [1]. The Virtio RTC (Real Time Clock) device
> > > provides information about current time. The device can provide diffe=
rent
> > > clocks, e.g. for the UTC or TAI time standards, or for physical time
> > > elapsed since some past epoch.=20
> >=20
> > Hm, should we allow UTC? If you tell me the time in UTC, then
> > (sometimes) I still don't actually know what the time is, because some
> > UTC seconds occur twice. UTC only makes sense if you provide the TAI
> > offset, surely? Should the virtio_rtc specification make it mandatory
> > to provide such?
> >=20
> > Otherwise you're just designing it to allow crappy hypervisors to
> > expose incomplete information.
> >=20
>=20
> Hi David,
>=20
> (adding virtio-comment@lists.oasis-open.org=C2=A0for spec discussion),
>=20
> thank you for your insightful comments. I think I take a broadly similar
> view. The reason why the current spec and driver is like this is that I
> took a pragmatic approach at first and only included features which work
> out-of-the-box for the current Linux ecosystem.
>=20
> The current virtio_rtc features work similar to ptp_kvm, and therefore ca=
n
> work out-of-the-box with time sync daemons such as chrony.
>=20
> As of RFC spec v3, UTC clock only is allowed. If mandating a TAI clock as
> well, I am afraid that
>=20
> - in some (embedded) scenarios, the TAI clock may not be available
>=20
> - crappy hypervisors will pass off the UTC clock as the TAI clock.
>=20
> For the same reasons, I am also not sure about adding a *mandatory* TAI
> offset to each readout. I don't know user-space software which would
> leverage this already (at least not through the PTP clock interface). And
> why would such software not go straight for the TAI clock instead?
>=20
> How about adding a requirement to the spec that the virtio-rtc device
> SHOULD expose the TAI clock whenever it is available - would this address
> your concerns?

I think that would be too easy for implementors to miss, or decide not
to obey. Or to get *wrong*, by exposing a TAI clock but actually
putting UTC in it.

I think I prefer to mandate the tai_offset field with the UTC clock.
Crappy implementations will just set it to zero, but at least that
gives a clear signal to the guests that it's *their* problem to
resolve.




> > > PTP clock interface
> > > -------------------
> > >=20
> > > virtio_rtc exposes clocks as PTP clocks to userspace, similar to ptp_=
kvm.
> > > If both the Virtio RTC device and this driver have special support fo=
r the
> > > current clocksource, time synchronization programs can use
> > > cross-timestamping using ioctl PTP_SYS_OFFSET_PRECISE2 aka
> > > PTP_SYS_OFFSET_PRECISE. Similar to ptp_kvm, system time synchronizati=
on
> > > with single-digit ns precision is possible with a quiescent reference=
 clock
> > > (from the Virtio RTC device). This works even when the Virtio device
> > > response is slow compared to ptp_kvm hypercalls.
> >=20
> > Is PTP the right mechanism for this? As I understand it, PTP is a way
> > to precisely synchronize one clock with another. But in the case of
> > virt guests synchronizing against the host, it isn't really *another*
> > clock. It really is the *same* underlying clock. As the host clock
> > varies with temperature, for example, so does the guest clock. The only
> > difference is an offset and (on x86 perhaps) a mathematical scaling of
> > the frequency.
> >=20
> > I was looking at this another way, when I came across this virtio-rtc
> > work.
> >=20
> > My idea was just for the hypervisor to expose its own timekeeping
> > information =E2=80=94 the counter/TSC value and TAI time at a given mom=
ent,
> > frequency of the counter, and the precision of both that frequency
> > (=C2=B1PPM) and the TAI timestamp (=C2=B1=C2=B5s).
> >=20
> > By putting that in a host/guest shared data structure with a seqcount
> > for lockless updates, we can update it as time synchronization on the
> > host is refined, and we can even cleanly handle live migration where
> > the guest ends up on a completely different host. It allows for use
> > cases which *really* care (e.g. timestamping financial transactions) to
> > ensure that there is never even a moment of getting *wrong* timestamps
> > if they haven't yet resynced after a migration.
>=20
> I considered a similar approach as well, but integrating that with the
> kernel timekeeping seemed too much effort for the first step. However,
> reading the clock from user space would be much simpler.

Right. In fact my *first* use case was userspace, specifically in the
context of https://github.com/aws/clock-bound =E2=80=94 but anything we des=
ign
for this absolutely has to be usable for kernel timekeeping too.

It's also critical to solve the Live Migration problem.

But is it so hard to integrate into the kernel timekeeping? My plan
would have given us effectively an infinite number of cross-reads of
the realtime clock vs. TSC. You don't have to actually read from a
virtio device; you just read the TSC and do the maths, using the values
in the shared memory region. Couldn't that be used to present a PTP
device to the guest kernel just the same as you do at the moment?

You could probably even simulate PPS with it. Typically with PPS we
have to catch the hardware interrupt and then read the TSC as soon as
possible thereafter. With this, you'd be able to *calculate* the TSC
value at the start of the next second, and wouldn't have to suffer the
real hardware latency :)

> >=20
> > Now I'm trying to work out if I should attempt to reconcile with your
> > existing virtio-rtc work, or just decide that virtio-rtc isn't trying
> > to solve the actual problem that we have, and go ahead with something
> > different... ?
> >=20
>=20
> We are certainly interested into the discussed, say, "virtual timekeeper"
> mechanism, which would also solve a lot of problems for us (especially if
> it would be integrated with kernel timekeeping). Even without Linux kerne=
l
> timekeeping, the virtual timekeeper would be useful to us for guests with
> simpler timekeeping, and potentially for user space applications.
>=20
> Our current intent is to at first try to upstream the current (RFC spec v=
3)
> feature set. I think the virtual timekeeper would be suitable as an
> optional feature of virtio_rtc (with Virtio, this could easily be added
> after initial upstreaming). It is also possible to have a virtio-rtc devi=
ce
> only implement the virtual timekeeper, but not the other clock reading
> methods, if these are of no interest.

Yeah, that might make sense. I was thinking of a simple ACPI/DT device
exposing a page of memory and *maybe* an interrupt for when an update
happens. (With the caveat that the interrupt would always occur too
late by definition, so it's no substitute for using the seqlock
correctly in applications that *really* care and are going to get fined
millions of dollars for mis-timestamping their transactions.)

But using the virtio-rtc device as the vehicle for that shared memory
page is reasonable too. It's not even mutually exclusive; we could
expose the *same* data structure in memory via whatever mechanisms we
wanted.

One other thing to note is I think we're being very na=C3=AFve about the TS=
C
on x86 hosts. Theoretically, the TSC for every vCPU might run at a
different frequency, and even if they run at the same frequency they
might be offset from each other. I'm happy to be na=C3=AFve but I think we
should be *explicitly* so, and just say for example that it's defined
against vCPU0 so if other vCPUs are different then all bets are off.=20

We *can* cope with TSC frequencies changing. Fundamentally, that's the
whole *point*; NTP calibrates itself as the underlying frequency does
change due to temperature changes, etc. =E2=80=94 so a deliberate frequency
scaling, or even a live migration, are just a slightly special case of
the same thing.

One thing I have added to the memory region is a migration counter. In
the ideal case, guests will be happy just to use the hypervisor's
synchronization. But in some cases the guests may want to do NTP (or
PPS, PTP or something else) for themselves, to have more precise
timekeeping than the host. Even if the host is advertising itself as
stratum 16, the guest still needs to know of *migration*, because it
has to consider itself unsynchronized when that happens.

--=-/Vg2r2b0Ohk48lHKnk9t
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwMzA4MTIzMzIwWjAvBgkqhkiG9w0BCQQxIgQgOjhIHSWt
p6n12nI5wmjr3lWoHazfLZdKSSSPllwUE3swgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBUPw4kBnN8L/YheIEdRUae8eNlT+npnOF8
3EWIR1YJkT3eY0lPNED4/IR+T4yjwfOZUrboJ3UFmC7JRLMQ6TQVXLE7lqlXL14y0fN9M+utOSrZ
OOh2uMbqccaBghFWceCKD/cBwPAbCDUDXSNgXxA+peDrSdAu7QM4XFshvyWLa1hwOWfQrauzTNre
Y2x0KrWydOL/7ghYvdUk+Tnz+XLUityzrkve3uOEYt09i9x6mwqfcXE+V5kgEVhGI6Iw8bAeNoXp
YavaIcmijjtEo62867BcvjLYqH4T0EvNxyAb7MzOmBm6piKzBBM90AVsK+z15tdG3sVJ+8gjwjSa
q2ZReiWN3ZP3xEHlMNx9JnX4+So4Yatm+mmc14S7CGKv1bMOsuBE7NfdRGSNMYlcWAN5P72nNr12
GG+TMwTA363HOyDON3NY6vK/CMtjfTfUX8LNhsgOa/f9BAKGBTTBcvPiSu50kpPJkw3cvLJaDo95
LDwcpHmlefMKdV0KkR4jYXHNj6HQLMQDlKMULS3L9zz58+ns6vXn6TWjST9XbLt9dCOOhY9TsNkE
yCP0qxjrzowmdzO4jCKXnzJpmIZIDIzi+3wf9KJIKwG5GCq9GI9/u2PFHz0EMlK3xcYjUgUyvfzm
L6EddjFPzfBdiAvuF5Padruy9IdhRVnd1niYBpZ3BQAAAAAAAA==


--=-/Vg2r2b0Ohk48lHKnk9t--

