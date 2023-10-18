Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC367CE7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjJRTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJRTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6995
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697657762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p74xZf+yvMFgKaF5SGRiPer5Qi122Y2wywp4B5ZGZis=;
        b=IvLrv6TXQojZYRLQHi/7kFZoewKjkfTn6DTJ3Bsa3mqLemU7bAK7bbh4gu1rmkAuM5clva
        ZNundZ/a3UpRwjossljQo/s2Ay8MpfkrWKFXb1HAsH1r3Uv2X3JsUUzY2rodkmKBoMan0d
        BSCe+PN20hQni1/kFR8Rb4jYCfAUBR8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-skjDXkUQMOmfJXR0nRgAkA-1; Wed, 18 Oct 2023 15:35:50 -0400
X-MC-Unique: skjDXkUQMOmfJXR0nRgAkA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c749c28651so81434166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657749; x=1698262549;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p74xZf+yvMFgKaF5SGRiPer5Qi122Y2wywp4B5ZGZis=;
        b=MQ/6ZHHC5j7uzuSMcbnuFIYzixx9/LysKPSmazSqIPiRFnjKzgJmGp1brGfnhGUrC2
         gL6QUQXuYIyQJgLw2s+sTBINNu1Y/uX6WCq+Z7lwGht4WjBvlG+LqVXAKyzQSWopmeOx
         wa6I7xylPqa8EHBGQ9TmDOhm2GNNx5/l+gQ25vNOp7rJZScO8QoLFUKlmPIPaxZwL9nr
         rMaBNqEn+ULd7U1td8Kkb7a1+vJsnWNbohkQFGuXzARuuytSRLNNjgowx2BNeslLnTIw
         iubGqtmcoxzVujDRDYyYozwZjqgtKqSnlGyEqRIABKZHab1O2rd8AdylYlc1R3fctRqj
         HRXQ==
X-Gm-Message-State: AOJu0YwXq/fM4IoLGHF4y8Y/QsrhxLLy+cBCQ3yiz5cCyymnpAg/IqcO
        53qpf9qOqr1uV53tkSA8aAzKOLBnH8ZAq8xz12o0/dX4S0jZsSwNzFwnM3mCU4Bf/Yn2LmXgfom
        JhcsTPhVspWFM69KeXOdCJSao
X-Received: by 2002:a17:907:a089:b0:9ad:e4e1:1476 with SMTP id hu9-20020a170907a08900b009ade4e11476mr157988ejc.77.1697657749463;
        Wed, 18 Oct 2023 12:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdQdPeTCK4i+cbcQKdHK2u/0dTKH9zU5i7ZCkooSVzDd3KiVk1qnMXkhWod2d2h7wau8SekA==
X-Received: by 2002:a17:907:a089:b0:9ad:e4e1:1476 with SMTP id hu9-20020a170907a08900b009ade4e11476mr157970ejc.77.1697657749094;
        Wed, 18 Oct 2023 12:35:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id le3-20020a170907170300b009c70b392051sm2214715ejc.100.2023.10.18.12.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:35:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------QZBWEzaD2g02goSPTYlOO0mq"
Message-ID: <d8c5c530-9eea-5acb-f7f7-7f7af56e700d@redhat.com>
Date:   Wed, 18 Oct 2023 21:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
To:     me@donjajo.com
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <132feb67-c147-7ee6-b337-385e11786ec6@redhat.com>
 <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
 <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
 <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
 <938c83c4-973d-ac23-bfb6-53c63c153d81@redhat.com>
 <6c97dc9e9cfea6e18c59d717e5973255@donjajo.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6c97dc9e9cfea6e18c59d717e5973255@donjajo.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------QZBWEzaD2g02goSPTYlOO0mq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi James,

On 10/18/23 02:17, me@donjajo.com wrote:
> Hi Hans,
> 
> I hope you are feeling better now.
> Thank you so much for your support in resolving this.
> 
>> I assume that the first "BACKLIGHT BUTTON" is the backlight DOWN button ?
> Yes. Correct.
> 
> 
>> 2. Can you please run:
>>
>> sudo evtest and then select the "ACPI video bus" (or something
>> similar) device and see if that reports brightness up/down
>> keypresses?  And then do the same thing for the
>> "Asus WMI hotkeys" device ? I expect the Asus WMI hotkeys
>> device to only report brightness up keypresses (after my
>> hwdb "fix") while I expect brightness-up events to get
>> reported twice, by both the "ACPI video bus" device and
>> the "Asus WMI hotkeys" device.
> Done and attached.
> 
>> Can you confirm this? This also means that brightness
>> up will take bigger steps (2 steps per keypress) then
>> brightness down, right ?
> I am not sure I understand what you mean here. But I have attached the output here

The 2 evtest logs show that each brightness up/down keypress
gets reported twice, once by the "ACPI video bus" device and
once bythe "Asus WMI hotkeys" device.

This means that in e.g. GNOME the brightness will move
up / down by 2 steps for each step, reducing the amount
of steps from 20 to 10, or iow making each step twice
as big. Especially at the low end of the brightness
scale this may be an issue since steeping by 5% there
can already make a big difference and this double
key press reporting now changes this into stepping
by 10% at a time.

> After applying your patch, it seems to have fixed the issue!

Thank you for all the testing and other then the double
keypress issue + the unknown code messages everything
now looks good!

I have applied 2 more patches the first one fixes the
unknown code messages and adds a mapping for the
"Screen Capture" hotkey. The second test filters out
the duplicate (duplicate with the "ACPI video bus")
brightness up/down events.

It would be great if you can add these on top of
the previous 2 patches and then run one last
test for me:

Run evtest on the "Asus WMI hotkeys" device this should now:

1. Show no output for capslock / printscreen

2. Show KEY_SELECTIVE_SCREENSHOT events for the
   "Screen Capture" hotkey.

3. Show no output for brightness up/down,
   yet brightness up/down should still work since
   these are also reported by the "ACPI video bus"

It would be great if you can confirm for each of these
that this behaves as expected with the 2 extra patches
applied on top of the previous patches.

Regards,

Hans

--------------QZBWEzaD2g02goSPTYlOO0mq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-asus-wmi-Map-0x2a-code-Ignore-0x2b-and-.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-asus-wmi-Map-0x2a-code-Ignore-0x2b-and-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhMjUzM2JkNTczZWI3YTc2MjMwNmU4M2Q5OWY2MjRjYmFiYWQ3ZDE5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUdWUsIDE3IE9jdCAyMDIzIDEwOjM1OjE0ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIHBsYXRmb3JtL3g4NjogYXN1cy13bWk6IE1hcCAweDJhIGNvZGUsIElnbm9y
ZSAweDJiIGFuZAogMHgyYyBldmVudHMKCk5ld2VyIEFzdXMgbGFwdG9wcyBzZW5kIHRoZSBm
b2xsb3dpbmcgbmV3IFdNSSBldmVudCBjb2RlcyB3aGVuIHNvbWUKb2YgdGhlIEYxIC0gRjEy
ICJtZWRpYSIgaG90a2V5cyBhcmUgcHJlc3NlZDoKCjB4MmEgU2NyZWVuIENhcHR1cmUKMHgy
YiBQcmludFNjcmVlbgoweDJjIENhcHNMb2NrCgpNYXAgMHgyYSB0byBLRVlfU0VMRUNUSVZF
X1NDUkVFTlNIT1QgbWlycm9yaW5nIGhvdyBzaW1pbGFyIGhvdGtleXMKYXJlIG1hcHBlZCBv
biBvdGhlciBsYXB0b3BzLgoKUHJpbnRTY3JlZW0gYW5kIENhcHNMb2NrIGFyZSBhbHNvIHJl
cG9ydGVkIGFzIG5vcm1hbCBQUy8yIGtleWJvYXJkIGV2ZW50cywKbWFwIHRoZXNlIGV2ZW50
IGNvZGVzIHRvIEtFX0lHTk9SRSB0byBhdm9pZCAiVW5rbm93biBrZXkgY29kZSAweCV4XG4i
IGxvZwptZXNzYWdlcy4KClJlcG9ydGVkLWJ5OiBKYW1lcyBKb2huIDxtZUBkb25qYWpvLmNv
bT4KQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wbGF0Zm9ybS1kcml2ZXIteDg2
L2EyYzQ0MWZlLTQ1N2UtNDRjZi1hMTQ2LTBlY2Q4NmIwMzdjZkBkb25qYWpvLmNvbS8KQ2xv
c2VzOiBodHRwczovL2Jicy5hcmNobGludXgub3JnL3ZpZXd0b3BpYy5waHA/cGlkPTIxMjM3
MTYKU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4K
LS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLW5iLXdtaS5jIHwgMyArKysKIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9hc3VzLW5iLXdtaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy1uYi13
bWkuYwppbmRleCBkODVkODk1ZmVlODkuLmRmMWRiNTRkNGUxOCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9wbGF0Zm9ybS94ODYvYXN1cy1uYi13bWkuYworKysgYi9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9hc3VzLW5iLXdtaS5jCkBAIC01MzEsNiArNTMxLDkgQEAgc3RhdGljIHZvaWQgYXN1
c19uYl93bWlfcXVpcmtzKHN0cnVjdCBhc3VzX3dtaV9kcml2ZXIgKmRyaXZlcikKIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qga2V5X2VudHJ5IGFzdXNfbmJfd21pX2tleW1hcFtdID0gewogCXsg
S0VfS0VZLCBBU1VTX1dNSV9CUk5fRE9XTiwgeyBLRVlfQlJJR0hUTkVTU0RPV04gfSB9LAog
CXsgS0VfS0VZLCBBU1VTX1dNSV9CUk5fVVAsIHsgS0VZX0JSSUdIVE5FU1NVUCB9IH0sCisJ
eyBLRV9LRVksIDB4MmEsIHsgS0VZX1NFTEVDVElWRV9TQ1JFRU5TSE9UIH0gfSwKKwl7IEtF
X0lHTk9SRSwgMHgyYiwgfSwgLyogUHJpbnRTY3JlZW4gKGFsc28gc2VuZCB2aWEgUFMvMikg
b24gbmV3ZXIgbW9kZWxzICovCisJeyBLRV9JR05PUkUsIDB4MmMsIH0sIC8qIENhcHNMb2Nr
IChhbHNvIHNlbmQgdmlhIFBTLzIpIG9uIG5ld2VyIG1vZGVscyAqLwogCXsgS0VfS0VZLCAw
eDMwLCB7IEtFWV9WT0xVTUVVUCB9IH0sCiAJeyBLRV9LRVksIDB4MzEsIHsgS0VZX1ZPTFVN
RURPV04gfSB9LAogCXsgS0VfS0VZLCAweDMyLCB7IEtFWV9NVVRFIH0gfSwKLS0gCjIuNDEu
MAoK
--------------QZBWEzaD2g02goSPTYlOO0mq
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-platform-x86-asus-wmi-Do-not-report-brightness-up-do.patch"
Content-Disposition: attachment;
 filename*0="0002-platform-x86-asus-wmi-Do-not-report-brightness-up-do.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlYzAxY2FjYWY2OGZjMDBjMWQ1ZmZmZDJjZThlMGJkMDNkMjc1M2JkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBXZWQsIDE4IE9jdCAyMDIzIDExOjQ3OjI4ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIHBsYXRmb3JtL3g4NjogYXN1cy13bWk6IERvIG5vdCByZXBvcnQgYnJpZ2h0
bmVzcyB1cC9kb3duCiBrZXlzIHdoZW4gYWxzbyByZXBvcnRlZCBieSBhY3BpX3ZpZGVvCgpG
b3IgYSBsb25nIHRpbWUgbm93IHRoZSBhY3BpX3ZpZGVvIGRyaXZlciByZXBvcnRzIGV2ZGV2
IGJyaWdodG5lc3MgdXAvZG93bgprZXkgZXZlbnRzIGZvciB0aGUgYnJpZ2h0bmVzcyBob3Rr
ZXlzIG9uIG1vc3QgKG5vbiBhbmNpZW50KSBsYXB0b3BzLgoKYXN1cy13bWkgYWxzbyByZXBv
cnRzIGV2ZGV2IGJyaWdodG5lc3MgdXAvZG93biBrZXkgZXZlbnRzIGZvciB0aGVzZQprZXlz
IGxlYWRpbmcgdG8gZWFjaCBwcmVzcyBiZWluZyByZXBvcnRlZCB0d2ljZSBhbmQgZS5nLiBH
Tk9NRSBpbmNyZWFzaW5nCnRoZSBicmlnaHRuZXNzIGJ5IDIgc3RlcHMgaW5zdGVhZCBvZiAx
IHN0ZXAuCgpVc2UgdGhlIGFjcGlfdmlkZW9faGFuZGxlc19icmlnaHRuZXNzX2tleV9wcmVz
c2VzKCkgaGVscGVyIHRvIGRldGVjdCBpZgphY3BpX3ZpZGVvIGlzIHJlcG9ydGluZyBicmln
aHRuZXNzIGtleS1wcmVzc2VzIGFuZCBpZiBpdCBpcyB0aGVuIGRvbid0CnJlcG9ydCB0aGUg
c2FtZSBldmVudHMgYWxzbyBmcm9tIHRoZSBhc3VzLXdtaSBkcml2ZXIuCgpOb3RlIHRoZXJl
IGlzIGEgY2hhbmNlIHRoYXQgdGhpcyBtYXkgbGVhZCB0byByZWdyZXNzaW9ucyB3aGVyZQp0
aGUgYnJpZ2h0bmVzcyBob3RrZXlzIHN0b3Agd29ya2luZyBiZWNhdXNlIHRoZXkgYXJlIG5v
dCBhY3R1YWxseQpyZXBvcnRlZCBieSB0aGUgYWNwaV92aWRlbyBkcml2ZXIuIFVuZm9ydHVu
YXRlbHkgdGhlIG9ubHkgd2F5IHRvCmZpbmQgb3V0IGlmIHRoaXMgaXMgYSBwcm9ibGVtIGlz
IHRvIHRyeS4KClRvIGF0IGxlYXN0IGF2b2lkIHJlZ3Jlc3Npb25zIG9uIG9sZCBodyB1c2lu
ZyB0aGUgZWVlcGMtd21pIGRyaXZlciwKaW1wbGVtZW50IHRoaXMgYXMgYSBrZXkgZmlsdGVy
IGluIGFzdXMtbmItd21pIHNvIHRoYXQgdGhlIGVlZXBjLXdtaQpkcml2ZXIgaXMgbm90IGFm
ZmVjdGVkLgoKUmVwb3J0ZWQtYnk6IEphbWVzIEpvaG4gPG1lQGRvbmpham8uY29tPgpDbG9z
ZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BsYXRmb3JtLWRyaXZlci14ODYvYTJjNDQx
ZmUtNDU3ZS00NGNmLWExNDYtMGVjZDg2YjAzN2NmQGRvbmpham8uY29tLwpTaWduZWQtb2Zm
LWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMv
cGxhdGZvcm0veDg2L2FzdXMtbmItd21pLmMgfCAxNiArKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2FzdXMtbmItd21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLW5i
LXdtaS5jCmluZGV4IGRmMWRiNTRkNGUxOC4uOWFhMTIyNmU3NGU2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLW5iLXdtaS5jCisrKyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2FzdXMtbmItd21pLmMKQEAgLTE2LDYgKzE2LDggQEAKICNpbmNsdWRlIDxsaW51
eC9kbWkuaD4KICNpbmNsdWRlIDxsaW51eC9pODA0Mi5oPgogCisjaW5jbHVkZSA8YWNwaS92
aWRlby5oPgorCiAjaW5jbHVkZSAiYXN1cy13bWkuaCIKIAogI2RlZmluZQlBU1VTX05CX1dN
SV9GSUxFCSJhc3VzLW5iLXdtaSIKQEAgLTYwNiw2ICs2MDgsMTkgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBrZXlfZW50cnkgYXN1c19uYl93bWlfa2V5bWFwW10gPSB7CiAJeyBLRV9FTkQs
IDB9LAogfTsKIAorc3RhdGljIHZvaWQgYXN1c19uYl93bWlfa2V5X2ZpbHRlcihzdHJ1Y3Qg
YXN1c193bWlfZHJpdmVyICphc3VzX3dtaSwgaW50ICpjb2RlLAorCQkJCSAgIHVuc2lnbmVk
IGludCAqdmFsdWUsIGJvb2wgKmF1dG9yZWxlYXNlKQoreworCXN3aXRjaCAoKmNvZGUpIHsK
KwljYXNlIEFTVVNfV01JX0JSTl9ET1dOOgorCWNhc2UgQVNVU19XTUlfQlJOX1VQOgorCQlp
ZiAoYWNwaV92aWRlb19oYW5kbGVzX2JyaWdodG5lc3Nfa2V5X3ByZXNzZXMoKSkKKwkJCSpj
b2RlID0gQVNVU19XTUlfS0VZX0lHTk9SRTsKKworCQlicmVhazsKKwl9Cit9CisKIHN0YXRp
YyBzdHJ1Y3QgYXN1c193bWlfZHJpdmVyIGFzdXNfbmJfd21pX2RyaXZlciA9IHsKIAkubmFt
ZSA9IEFTVVNfTkJfV01JX0ZJTEUsCiAJLm93bmVyID0gVEhJU19NT0RVTEUsCkBAIC02MTQs
NiArNjI5LDcgQEAgc3RhdGljIHN0cnVjdCBhc3VzX3dtaV9kcml2ZXIgYXN1c19uYl93bWlf
ZHJpdmVyID0gewogCS5pbnB1dF9uYW1lID0gIkFzdXMgV01JIGhvdGtleXMiLAogCS5pbnB1
dF9waHlzID0gQVNVU19OQl9XTUlfRklMRSAiL2lucHV0MCIsCiAJLmRldGVjdF9xdWlya3Mg
PSBhc3VzX25iX3dtaV9xdWlya3MsCisJLmtleV9maWx0ZXIgPSBhc3VzX25iX3dtaV9rZXlf
ZmlsdGVyLAogfTsKIAogCi0tIAoyLjQxLjAKCg==

--------------QZBWEzaD2g02goSPTYlOO0mq--

