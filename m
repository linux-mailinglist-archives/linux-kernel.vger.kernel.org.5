Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F07F5AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjKWJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:00:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90EC101
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
        From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nUySaiZIHbzQMqhUSZzYBrexCjSUPA5gptkYqkACE0w=; b=IyAiEJDGSLJssH2rFgULlC1xUV
        3frHJYIOe4HK43YLXJ1U+hMtAdlPGMYMY/9y/DG9SrB0OLnTw7Jviv15wlfWGrNtSr1ckRrFybmWF
        DZI3WRLx1/M1DUnI0UER0ey6mJUZ0MeArpn7nmo1KT182AdbIKFaNqIjT+elgUgmgI/3GYWaJuuF2
        3boy6nTv8oD8nGOVxbmgcFhiSJwyO/8M0YBLw9PN/aoC50bRRB9+MoyMztMZDwlZNYAwSPzpyPmc/
        0ejX89T/ZZlvu3bJue1hjh5CAgVXANcp5I82t77ngFn/9YAE2fVbmNS8EJk3aKR1zf7lvYxzqJGt9
        NwzqQfag==;
Received: from [2001:8b0:10b:5:aa35:270f:6b3d:6d64] (helo=u3832b3a9db3152.ant.amazon.com)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r65Zi-007Lr3-2a; Thu, 23 Nov 2023 09:00:42 +0000
Message-ID: <99771ef3a4966a01fefd3adbb2ba9c3a75f97cf2.camel@infradead.org>
Subject: CONFIG_PROVE_RAW_LOCK_NESTING false positive?
From:   David Woodhouse <dwmw2@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Nov 2023 09:00:41 +0000
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-bHRbi+i+Y46flWdfjNYv"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bHRbi+i+Y46flWdfjNYv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is this telling me that I'm no longer allowed to take a read_lock() in
a callback for an HRTIMER_MODE_ABS_HARD timer? Is that intentional?

If I must, I can probably cope with this by using read_trylock()
instead. The object being locked is a cache, and we opportunistically
try to use it from the fast path but fall back to a slow path in
process context which will revalidate and try again. So if someone
*has* taken the write lock, it's a fairly safe bet that the cache is
going to be invalidated and we were going to take the slow path anyway.

[   62.336965] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   62.336973] [ BUG: Invalid wait context ]
[   62.336992] 6.7.0-rc1+ #1437 Tainted: G          I      =20
[   62.337001] -----------------------------
[   62.337008] qemu-system-x86/1935 is trying to lock:
[   62.337017] ffffc900018fecc0 (&gpc->lock){....}-{3:3}, at: kvm_xen_set_e=
vtchn_fast+0xe7/0x460 [kvm]
[   62.337133] other info that might help us debug this:
[   62.337142] context-{2:2}
[   62.337148] 2 locks held by qemu-system-x86/1935:
[   62.337156]  #0: ffff888108f780b0 (&vcpu->mutex){+.+.}-{4:4}, at: kvm_vc=
pu_ioctl+0x7f/0x730 [kvm]
[   62.337239]  #1: ffffc900018ff2d8 (&kvm->srcu){.?.+}-{0:0}, at: kvm_xen_=
set_evtchn_fast+0xcd/0x460 [kvm]
[   62.337339] stack backtrace:
[   62.337346] CPU: 7 PID: 1935 Comm: qemu-system-x86 Tainted: G          I=
        6.7.0-rc1+ #1437
[   62.337370] Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5C6=
10.86B.01.01.0008.021120151325 02/11/2015
[   62.337384] Call Trace:
[   62.337390]  <IRQ>
[   62.337395]  dump_stack_lvl+0x57/0x90
[   62.337407]  __lock_acquire+0x7bb/0xbb0
[   62.337416]  ? __lock_acquire+0x4f0/0xbb0
[   62.337425]  lock_acquire.part.0+0xad/0x240
[   62.337433]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
[   62.337512]  ? rcu_is_watching+0xd/0x40
[   62.337520]  ? lock_acquire+0xf2/0x110
[   62.337529]  __raw_read_lock_irqsave+0x4e/0xa0
[   62.337538]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
[   62.337604]  kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
[   62.337669]  ? kvm_xen_set_evtchn_fast+0xcd/0x460 [kvm]
[   62.337734]  xen_timer_callback+0x86/0xc0 [kvm]
[   62.337799]  ? __pfx_xen_timer_callback+0x10/0x10 [kvm]
[   62.337863]  __hrtimer_run_queues+0x1b2/0x380
[   62.337874]  hrtimer_interrupt+0xfe/0x240
[   62.337883]  __sysvec_apic_timer_interrupt+0x85/0x1d0
[   62.337893]  sysvec_apic_timer_interrupt+0x99/0xc0
[   62.337905]  </IRQ>
[   62.337910]  <TASK>
[   62.337914]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   62.337925] RIP: 0010:vcpu_enter_guest.constprop.0+0x9c5/0x1240 [kvm]
[   62.337994] Code: 00 00 48 89 df e8 9b e2 12 00 48 83 bb 38 08 00 00 00 =
0f 85 ac 01 00 00 c6 83 32 0b 00 00 01 e8 c1 e9 8a e0 fb 0f 1f 44 00 00 <48=
> 83 83 c0 1c 00 00 01 9c 58 0f 1f 40 00 48 89 c2 fa 0f 1f 44 00
[   62.338241] RSP: 0018:ffffc90001923d70 EFLAGS: 00000206
[   62.338465] RAX: 000000000002ce1d RBX: ffff888108f78000 RCX: 00000000000=
00040
[   62.338692] RDX: 0000000000000000 RSI: ffffffff82569339 RDI: ffffffff824=
f5def
[   62.338919] RBP: ffffc90001923de0 R08: 0000000000000001 R09: 00000000000=
00000
[   62.339172] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   62.339396] R13: 0000000000000001 R14: 0000000000000000 R15: ffff888108f=
78000
[   62.339617]  ? vcpu_run+0x40/0x430 [kvm]
[   62.339888]  vcpu_run+0x40/0x430 [kvm]
[   62.340173]  kvm_arch_vcpu_ioctl_run+0x1da/0x680 [kvm]
[   62.340443]  kvm_vcpu_ioctl+0x1a1/0x730 [kvm]
[   62.340702]  ? __fget_files+0xbc/0x190
[   62.340915]  __x64_sys_ioctl+0x93/0xd0
[   62.341125]  do_syscall_64+0x36/0xb0
[   62.341335]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   62.341544] RIP: 0033:0x7f180b200ecd
[   62.341745] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 =
b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   62.342178] RSP: 002b:00007f1802bb1560 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   62.342398] RAX: ffffffffffffffda RBX: 00005601bc1b8530 RCX: 00007f180b2=
00ecd
[   62.342616] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00000000000=
0000c
[   62.342832] RBP: 00007f1802bb15b0 R08: 00005601ba5a27d0 R09: 00000000000=
00000
[   62.343046] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[   62.343256] R13: 0000000000000022 R14: 0000000000000007 R15: 00007ffeac3=
c08a0
[   62.343463]  </TASK>


--=-bHRbi+i+Y46flWdfjNYv
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMxMTIzMDkwMDQxWjAvBgkqhkiG9w0BCQQxIgQghsdMaXax
LwqeyETzfpJfIMgq8ZUvVZkFAK5YDJDecWowgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAIdkEGEKat9gfpLuG+R41stt1a6sA0Dx73
a/s8wN3UbGSQIc89JjDLFiT7/eyWEuOzJV6UrZGoWHp40XENBKyiUm8winL+cRfXRDBXTHGyX8dA
s03c8kd3nb6SIxEiVUSHBEfm1dX1qVy+Kyw796SX/ESomeoBIP0R/cfjLGVqbXeNRdTZGdJirTLI
mfrBoDogIksEl5hQvutBj6ngEiTCOnSh8V1woEoa7PXGSs/PwKNvne7Y8ep+hWnM0tr44uUBHW6d
AqrBfCxZEPHLQoYwNIQH2ABtMBtf4CHEquPOmW2UnXaJGKaK1kt4KAJOM6p025Kgb4GRXpljqoF0
vhCMWKIq1u49RWm25ghIK63jpsLazg6syIYglscDGfrebZK+PTq+MGoPXnAZWEakE6EZ6RpHoL0d
FWm5TIBNu/eVJcgX6WZyGSFO+JEToPJe6lCwN1W2CvNAPbNSXmL3mr5nD3FhsVe3pxJTUbJkinsT
XnNjFth5G6TPEtQDRavqxfGmiQz1BIlO2CJ310d0DzdH6VDncGJl68pL89BGeswkKGqxxZm1BDih
UjmLrLh7I73jyK9FBu0anD/Y/pSX7uEShsb5rIaViPptSh8hIV/dk6Vy2R7Iixb6FQ/LLSP5B4kG
m39C3n9OQDrlYENXrD+QVcUm5G9/3gx2Ti19Au/yuAAAAAAAAA==


--=-bHRbi+i+Y46flWdfjNYv--
