Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9E7B02A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjI0LUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjI0LU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:20:29 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D6193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:20:26 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C1DA624002A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1695813624; bh=Sm0zxM7O/i60NLNvSviHQemdaF2HDOm/QoewQiI0zbk=;
        h=Message-ID:Subject:From:To:Cc:Date:Content-Transfer-Encoding:
         MIME-Version:From;
        b=fTk8Ubev8wyyua73JyBC7Cfn5tUJxtndrUQsmwP9rPLqpYUG8Kph3NaNU2X8dWR4z
         oeCM76ryDnQXBVUH5trE1mBrBSmrX+bNbdGKEkq713nit+fdCCKmR2cb/Fei0usOGs
         aC7VbhQVqQ8H9MXxCdTftzyR+yO/JQDFwXz/GzpxWLlJdZcHVSq/SL6G+E/sXksYPk
         aLqV6v4dq7urAAdBTtl/IQ2/qKXHiLDqeT9bqO/i1DUQ02czacd+Nt2rrR3XGQGmos
         4d++p636yDmStwvdWp0fseWzAzmqDASt0sGnjh42WQpeIv3DoYrSQuN6B64wcA7RRv
         jHSaMJ4FAhaVw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RwZ0R6m4qz9s2W;
        Wed, 27 Sep 2023 13:20:23 +0200 (CEST)
Message-ID: <137ee9ed434fe98fd773cd27895afc564f92a23c.camel@posteo.de>
Subject: Re: [RFC PATCH 2/2] hid: lenovo: move type checks to
 lenovo_features_set_cptkbd()
From:   Martin Kepplinger <martink@posteo.de>
To:     Jamie Lentin <jm@lentin.co.uk>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Wed, 27 Sep 2023 11:20:23 +0000
In-Reply-To: <ef0f15c3b17ebbd58f7481910b3f40ff@lentin.co.uk>
References: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
         <20230925102302.13094-1-martink@posteo.de>
         <20230925102302.13094-2-martink@posteo.de>
         <ef0f15c3b17ebbd58f7481910b3f40ff@lentin.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gTWl0dHdvY2gsIGRlbSAyNy4wOS4yMDIzIHVtIDA5OjE5ICswMTAwIHNjaHJpZWIgSmFtaWUg
TGVudGluOgo+IE9uIDIwMjMtMDktMjUgMTE6MjMsIE1hcnRpbiBLZXBwbGluZ2VyIHdyb3RlOgo+
ID4gVGhlc2UgY3VzdG9tIGNvbW1hbmRzIHdpbGwgYmUgc2VudCB0byBib3RoIHRoZSBVU0Iga2V5
Ym9hcmQgJiBtb3VzZQo+ID4gZGV2aWNlcyBidXQgb25seSB0aGUgbW91c2Ugd2lsbCByZXNwb25k
LiBBdm9pZCBzZW5kaW5nIGtub3duLQo+ID4gdXNlbGVzcwo+ID4gbWVzc2FnZXMgYnkgYWx3YXlz
IHByZXBlbmRpbmcgdGhlIGZpbHRlciBiZWZvcmUgc2VuZGluZyB0aGVtLgo+ID4gCj4gPiBTdWdn
ZXN0ZWQtYnk6IEphbWllIExlbnRpbiA8am1AbGVudGluLmNvLnVrPgo+ID4gU2lnbmVkLW9mZi1i
eTogTWFydGluIEtlcHBsaW5nZXIgPG1hcnRpbmtAcG9zdGVvLmRlPgo+ID4gLS0tCj4gPiDCoGRy
aXZlcnMvaGlkL2hpZC1sZW5vdm8uYyB8IDI3ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQo+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiA+
IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1sZW5vdm8uYyBiL2RyaXZlcnMvaGlk
L2hpZC1sZW5vdm8uYwo+ID4gaW5kZXggMjlhYTZkMzcyYmFkLi45MjJmM2U1NDYyZjQgMTAwNjQ0
Cj4gPiAtLS0gYS9kcml2ZXJzL2hpZC9oaWQtbGVub3ZvLmMKPiA+ICsrKyBiL2RyaXZlcnMvaGlk
L2hpZC1sZW5vdm8uYwo+ID4gQEAgLTUyMSw2ICs1MjEsMTQgQEAgc3RhdGljIHZvaWQgbGVub3Zv
X2ZlYXR1cmVzX3NldF9jcHRrYmQoc3RydWN0Cj4gPiBoaWRfZGV2aWNlICpoZGV2KQo+ID4gwqDC
oMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGxlbm92b19k
cnZkYXRhICpjcHRrYmRfZGF0YSA9IGhpZF9nZXRfZHJ2ZGF0YShoZGV2KTsKPiA+IAo+ID4gK8Kg
wqDCoMKgwqDCoMKgLyogQWxsIHRoZSBjdXN0b20gYWN0aW9uIGhhcHBlbnMgb24gdGhlIFVTQk1P
VVNFIGRldmljZSBmb3IKPiA+IFVTQiAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCgoaGRldi0+
cHJvZHVjdCA9PSBVU0JfREVWSUNFX0lEX0xFTk9WT19DVVNCS0JEKSB8fAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgIChoZGV2LT5wcm9kdWN0ID09IFVTQl9ERVZJQ0VfSURfTEVOT1ZPX1RQSUlV
U0JLQkQpKSAmJgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIGhkZXYtPnR5cGUgIT0gSElEX1RZ
UEVfVVNCTU9VU0UpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoaWRfZGJn
KGhkZXYsICJJZ25vcmluZyBrZXlib2FyZCBoYWxmIG9mCj4gPiBkZXZpY2VcbiIpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiA+ICvCoMKgwqDCoMKgwqDCoH0K
PiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIFRlbGwg
dGhlIGtleWJvYXJkIGEgZHJpdmVyIHVuZGVyc3RhbmRzIGl0LCBhbmQgdHVybiBGNywKPiA+IEY5
LCBGMTEgCj4gPiBpbnRvCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogcmVndWxhciBrZXlzCj4gPiBA
QCAtMTEyMiwxNCArMTEzMCw2IEBAIHN0YXRpYyBpbnQgbGVub3ZvX3Byb2JlX2NwdGtiZChzdHJ1
Y3QKPiA+IGhpZF9kZXZpY2UgCj4gPiAqaGRldikKPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBsZW5vdm9fZHJ2ZGF0YSAqY3B0a2JkX2RhdGE7
Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqDCoC8qIEFsbCB0aGUgY3VzdG9tIGFjdGlvbiBoYXBwZW5z
IG9uIHRoZSBVU0JNT1VTRSBkZXZpY2UgZm9yCj4gPiBVU0IgKi8KPiA+IC3CoMKgwqDCoMKgwqDC
oGlmICgoKGhkZXYtPnByb2R1Y3QgPT0gVVNCX0RFVklDRV9JRF9MRU5PVk9fQ1VTQktCRCkgfHwK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCAoaGRldi0+cHJvZHVjdCA9PSBVU0JfREVWSUNFX0lE
X0xFTk9WT19UUElJVVNCS0JEKSkgJiYKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBoZGV2LT50
eXBlICE9IEhJRF9UWVBFX1VTQk1PVVNFKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaGlkX2RiZyhoZGV2LCAiSWdub3Jpbmcga2V5Ym9hcmQgaGFsZiBvZgo+ID4gZGV2aWNl
XG4iKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+IC3C
oMKgwqDCoMKgwqDCoH0KPiA+IC0KPiAKPiBJIGxpa2UgdGhlIGlkZWEgb2YgZG9pbmcgaXQgb25j
ZSB0aGVuIGZvcmdldHRpbmcgYWJvdXQgaXQsIGJ1dAo+IHJlbW92aW5nIAo+IHRoaXMgd2lsbCBt
ZWFuIHRoYXQgdGhlICJrZXlib2FyZCBoYWxmIiB3aWxsIGhhdmUgaXQncyBvd24gc2V0IG9mIAo+
IG5vbi1mdW5jdGlvbmFsIHN5c2ZzIHBhcmFtZXRlcnMgSSB0aGluaz8gQ3VycmVudGx5Oi0KPiAK
PiAjIGV2dGVzdAo+IMKgwqAgLiAuIC4KPiAvZGV2L2lucHV0L2V2ZW50MTA6wqDCoMKgwqAgVGhp
bmtQYWQgQ29tcGFjdCBCbHVldG9vdGggS2V5Ym9hcmQgd2l0aCAKPiBUcmFja1BvaW50Cj4gL2Rl
di9pbnB1dC9ldmVudDExOsKgwqDCoMKgIExlbm92byBUaGlua1BhZCBDb21wYWN0IFVTQiBLZXli
b2FyZCB3aXRoIAo+IFRyYWNrUG9pbnQKPiAvZGV2L2lucHV0L2V2ZW50MTI6wqDCoMKgwqAgTGVu
b3ZvIFRoaW5rUGFkIENvbXBhY3QgVVNCIEtleWJvYXJkIHdpdGggCj4gVHJhY2tQb2ludAo+IAo+
ICMgbHMgLTEgL3N5cy9jbGFzcy9pbnB1dC9ldmVudCovZGV2aWNlL2RldmljZS9mbl9sb2NrCj4g
L3N5cy9jbGFzcy9pbnB1dC9ldmVudDEwL2RldmljZS9kZXZpY2UvZm5fbG9jawo+IC9zeXMvY2xh
c3MvaW5wdXQvZXZlbnQxMi9kZXZpY2UvZGV2aWNlL2ZuX2xvY2sKPiAKPiAobm90ZSAxMSBpcyBt
aXNzaW5nLikKPiAKPiBJIHRoaW5rIHRoZSBlYXNpZXN0IChidXQgdWdseSkgdGhpbmcgdG8gZG8g
aXMgdG8gY29weS1wYXN0ZSB0aGlzIGx1bXAKPiBvZiAKPiBjb2RlIHRvIHRoZSB0b3Agb2YgbGVu
b3ZvX3Jlc2V0X3Jlc3VtZS4KPiBDaGVlcnMsCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgY3B0a2Jk
X2RhdGEgPSBkZXZtX2t6YWxsb2MoJmhkZXYtPmRldiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgc2l6ZW9mKCpjcHRrYmRfZGF0YSksCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdGUF9L
RVJORUwpOwo+ID4gQEAgLTEyNjQsMTYgKzEyNjQsNyBAQCBzdGF0aWMgaW50IGxlbm92b19wcm9i
ZShzdHJ1Y3QgaGlkX2RldmljZQo+ID4gKmhkZXYsCj4gPiDCoCNpZmRlZiBDT05GSUdfUE0KPiA+
IMKgc3RhdGljIGludCBsZW5vdm9fcmVzZXRfcmVzdW1lKHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2
KQo+ID4gwqB7Cj4gPiAtwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGhkZXYtPnByb2R1Y3QpIHsKPiA+
IC3CoMKgwqDCoMKgwqDCoGNhc2UgVVNCX0RFVklDRV9JRF9MRU5PVk9fQ1VTQktCRDoKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaGRldi0+dHlwZSA9PSBISURfVFlQRV9V
U0JNT1VTRSkgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBsZW5vdm9fZmVhdHVyZXNfc2V0X2NwdGtiZChoZGV2KTsKPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAtCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7Cj4gPiAtwqDCoMKgwqDCoMKgwqBkZWZhdWx0Ogo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gLcKgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKg
wqDCoMKgbGVub3ZvX2ZlYXR1cmVzX3NldF9jcHRrYmQoaGRldik7Cgpvay4gaWdub3JlIG15IGNo
YW5nZSAodGhpcyB3aG9sZSBwYXRjaCkgYW5kIGxvb2sgYXQgeW91ciBhZGRpdGlvbiBoZXJlLApk
b24ndCB5b3UgYWxyZWFkeSBtYWtlIHN1cmUgb25seSB0aGUgbW91c2UtcGFydCBnZXRzIHRoZSBt
ZXNzYWdlcz8geW91Cmp1c3Qgd3JpdGUgc3dpdGNoKCljYXNlIGluc3RlYWQgb2YgaWYoKTsgd2hh
dCBkbyB5b3UgdGhpbmsgaXMgbWlzc2luZwpoZXJlPwoKdGhhbmtzLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICBtYXJ0aW4KCj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+
IMKgfQoK

