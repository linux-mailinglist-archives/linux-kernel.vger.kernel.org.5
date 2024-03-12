Return-Path: <linux-kernel+bounces-100584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E91879A72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC331F21BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366A1384A8;
	Tue, 12 Mar 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPNMq01P"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268361272D0;
	Tue, 12 Mar 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263753; cv=none; b=Td7VHkqTCVqDkhh7w331g5dSk9eVzfH8t8Wqlm0966X0mHlCZSOSlVJ9M+lF4WLlSUcvMJnvxcGjeSPDqLiH44SJwihazdYnWVXFtp1WcFKQT5kccnaSG/LbGZg3Mt1YpWXBet47oZq9ekEfjDFi+aQuMFGdIPthcObdH+YYZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263753; c=relaxed/simple;
	bh=hP6O4F6KHaxoJOokQvq4p+HLTnOsym32ehhgS/j8nwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DdWohULXpkc6iw1Rf8sctkysRWht4OUmfpKqAe3+/q7fcUJHO1av1sOt7IBR5LRwZ9dbcGtywI5ImTCxVj6uve6+XfveoWhokKI+PexGENqTl7YxVEpxTzhUrYUctx4FipbCW1IyRv2gDZ2Nl7btMEj8UT+Bj1mcS6+TYSOGPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OPNMq01P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hP6O4F6KHaxoJOokQvq4p+HLTnOsym32ehhgS/j8nwQ=; b=OPNMq01Pn1n403XU1zRztr7UzD
	UJ+araWkye1l0bnyNVMTFR/wjVCKzX47jXwDkATWay0sT53fbG63UgY5n6qM6LU2ribNUwsObT3ll
	QL8HRcSC8ellAI5aUFF1hFkqreq+NWTeJEC0sPCVns/xy67X1P9AQGMyooo9m8D/KRzkR7LW6B3lD
	9N086Ou8tsbUbLW7DcETuPUbrKJO57AcOjvfbTWGmb5KRXfGWiRvWERj0rOx60EMnkqI+8kHzg2+r
	2JKp5Ozn8rmPEGPPEBPV6evhXFzJ/kEESi3BW0lt6X+eMFXuN7rBC1QXs5F/axIfkYVSML1TIAiQ7
	72KqMMEw==;
Received: from [2001:8b0:10b:5:4f46:ad9a:6045:e619] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk5j8-00000003VTd-2CPL;
	Tue, 12 Mar 2024 17:15:46 +0000
Message-ID: <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
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
Date: Tue, 12 Mar 2024 17:15:45 +0000
In-Reply-To: <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
	 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
	 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
	 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
	 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-zAvFWx7m/ZpGz+sU+igV"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-zAvFWx7m/ZpGz+sU+igV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-03-11 at 19:24 +0100, Peter Hilber wrote:
> On 08.03.24 13:33, David Woodhouse wrote:
> > On Fri, 2024-03-08 at 11:32 +0100, Peter Hilber wrote:
> > > On 07.03.24 15:02, David Woodhouse wrote:
> > > > Hm, should we allow UTC? If you tell me the time in UTC, then
> > > > (sometimes) I still don't actually know what the time is, because s=
ome
> > > > UTC seconds occur twice. UTC only makes sense if you provide the TA=
I
> > > > offset, surely? Should the virtio_rtc specification make it mandato=
ry
> > > > to provide such?
> > > >=20
> > > > Otherwise you're just designing it to allow crappy hypervisors to
> > > > expose incomplete information.
> > > >=20
> > >=20
> > > Hi David,
> > >=20
> > > (adding virtio-comment@lists.oasis-open.org=C2=A0for spec discussion)=
,
> > >=20
> > > thank you for your insightful comments. I think I take a broadly simi=
lar
> > > view. The reason why the current spec and driver is like this is that=
 I
> > > took a pragmatic approach at first and only included features which w=
ork
> > > out-of-the-box for the current Linux ecosystem.
> > >=20
> > > The current virtio_rtc features work similar to ptp_kvm, and therefor=
e
> > > can work out-of-the-box with time sync daemons such as chrony.
> > >=20
> > > As of RFC spec v3, UTC clock only is allowed. If mandating a TAI cloc=
k
> > > as well, I am afraid that
> > >=20
> > > - in some (embedded) scenarios, the TAI clock may not be available
> > >=20
> > > - crappy hypervisors will pass off the UTC clock as the TAI clock.
> > >=20
> > > For the same reasons, I am also not sure about adding a *mandatory* T=
AI
> > > offset to each readout. I don't know user-space software which would
> > > leverage this already (at least not through the PTP clock interface).
> > > And why would such software not go straight for the TAI clock instead=
?
> > >=20
> > > How about adding a requirement to the spec that the virtio-rtc device
> > > SHOULD expose the TAI clock whenever it is available - would this
> > > address your concerns?
> >=20
> > I think that would be too easy for implementors to miss, or decide not
> > to obey. Or to get *wrong*, by exposing a TAI clock but actually
> > putting UTC in it.
> >=20
> > I think I prefer to mandate the tai_offset field with the UTC clock.
> > Crappy implementations will just set it to zero, but at least that
> > gives a clear signal to the guests that it's *their* problem to
> > resolve.
>=20
> To me there are some open questions regarding how this would work. Is the=
re
> a use case for this with the v3 clock reading methods, or would it be
> enough to address this with the Virtio timekeeper?
>=20
> Looking at clock_adjtime(2), the tai_offset could be exposed, but probabl=
y
> best alongside some additional information about leap seconds. I am not
> aware about any user-space user. In addition, leap second smearing should
> also be addressed.
>=20

Is there even a standard yet for leap-smearing? Will it be linear over
1000 seconds like UTC-SLS? Or semi-raised-cosine over 24 hours, which I
think is what Google does? Meta does something different again, don't
they?

Exposing UTC as the only clock reference is bad enough; when leap
seconds happen there's a whole second during which you don't *know*
which second it is. It seems odd to me, for a precision clock to be
deliberately ambiguous about what the time is!

But if the virtio-rtc clock is defined as UTC and then expose something
*different* in it, that's even worse. You potentially end up providing
inaccurate time for a whole *day* leading up to the leap second.

I think you're right that leap second smearing should be addressed. At
the very least, by making it clear that the virtio-rtc clock which
advertises UTC shall be used *only* for UTC, never UTC-SLS or any other
yet-to-be-defined variant.

Please make it explicit that any hypervisor which wants to advertise a
smeared clock shall define a new type which specifies the precise
smearing algorithm and cannot be conflated with the one you're defining
here.

> > One other thing to note is I think we're being very na=C3=AFve about th=
e TSC
> > on x86 hosts. Theoretically, the TSC for every vCPU might run at a
> > different frequency, and even if they run at the same frequency they
> > might be offset from each other. I'm happy to be na=C3=AFve but I think=
 we
> > should be *explicitly* so, and just say for example that it's defined
> > against vCPU0 so if other vCPUs are different then all bets are off.
>=20
> ATM Virtio has no notion of vCPUs, or vCPU topology. So I wonder if you
> have an opinion on how to represent this in a platform-independent way.

Well, it doesn't have a notion of TSCs either; you include that by
implicit reference don't you?


--=-zAvFWx7m/ZpGz+sU+igV
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwMzEyMTcxNTQ1WjAvBgkqhkiG9w0BCQQxIgQg2cRyivyi
UXQFJD7FdkPsWpgAlUijBTbQczFRCGPPnS8wgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBvQrO2IohSCgMrOvEmutyNPo0atkF8zAg7
7KQvD1nPTz2SAW/JMH5YZWTcb5qlDSEsGF6Xn+FfPQyQrU6F2PShVNQzxTh59YdwuuJMaz4hGXks
5eYXSKsFG2DCoLKsYOAI++b5O3LFpkeXkZ8Mlt9eRKaRX8FR3BLaJRtmkYt1n7M5OvOo8B4DctAo
N3LKSsYYtXlC1LlF1yb4n1BVHmwW+M3W6cumL5UcjMmEvnp49VbYh0ePvz+3zoCw48LB9sirtQP1
uXlg0SVH3kotlxHLJbrSAifaq2cb0UH2IMcl2mPSAfWVe8HGKrFW40y9o1YIBhiSBash07gaC9Sz
3/yb00O0LugBtMrvoHLx6L5U+q2bAebzpXiFqTZAXM7IGdf0WJG37vHAbCbjA8pKwdg8rFY+FCxA
txzzvIXjbgs6aNJO8bxW9aaKTNbW8hXjcSpWI6M/2439EVkjLIYiLieQpzDDpaXkJvsGYF/Fub8Z
4BnUrMzenNMffzGflChZ5YnzqwRbCyHuxpyr26B7NAoZQwc1AtKQPtgj+y3qoP4zwNXm8bY2Lknc
lkAJzF1DSmtsCQAIyp9JHZXhXRjEcRvstRzo1+MObMkbACyIXaXPZaKVE5rCQR3BM8Mil46vZpnH
lOC5zg6S4ZDLAhnA4f1sNDU9p4ocoHdodz2QN/vR6gAAAAAAAA==


--=-zAvFWx7m/ZpGz+sU+igV--

