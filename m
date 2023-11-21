Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3608B7F389D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjKUV5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKUV5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FD113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700603829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H07C20s2TDfR/sNQMAMtbpycAkdXquM7amrlSJ1/Yl0=;
        b=N+Mwwt/8n+M8BzIEugYTbI/PXuI4FboBcon6shOEZHgqKqISexQpvhvJ/NOJCjsl04RiX/
        RMfrOBcQUklvdpCHtNU2XFdMiIzErc1BNd2NBBtCHQ+Ph2ZZLviFlTzeeC9p0CEq//DYIq
        krqvwCO0PgcfbfSu8AfXYllqoRX1TJA=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-fbcTmF1OMMWAsqGKkaDxFw-1; Tue, 21 Nov 2023 16:57:08 -0500
X-MC-Unique: fbcTmF1OMMWAsqGKkaDxFw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7bb4120b962so1998546241.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700603828; x=1701208628;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H07C20s2TDfR/sNQMAMtbpycAkdXquM7amrlSJ1/Yl0=;
        b=ohgIU7kyNC9UATIWCEGh5smloXQyvYkwogAaMLpkEw7f/pvEbiPRhqi7YN7CXe7OO8
         +ZyLjeqiCNp0ZMnWA1is+pnHI98HEV7i+k332d84hOq9Ni/DxMjGyLMJKRYD5V5MadhR
         HOSbeRUkY8kmAxME8FSMdiqG8gdSWAVh9yKpZeQqNeK+YcH8FAR7V6oq05M79SJzaNHZ
         OQoIkMmqU1+Us3kl0iEqsekYikrA+5AjebrPqEm59XqPjyV8IbYfe0xTvWBTwlY4kCQN
         PFFBLkq/uz/MsjQuyn0OlsFZorKQFdwL4hWzD+fLYwTLGy+TN9G6qZTWs+GtzeND5y++
         GjbA==
X-Gm-Message-State: AOJu0Yzxh+3iSkDzBDpkAYfIT/nCctaD18AbNiz8S4qMjw473jNGv4w+
        OcZRuatEaBodTqlG8tODdFkwU0fPQIxGzECy5EBPdbBrM6AzQ1LoWpVZnD34apZz0fKbcktrw6X
        Eiy3GeQQgDzaIAZskUgKflzs9
X-Received: by 2002:a67:e98a:0:b0:460:3dd3:a068 with SMTP id b10-20020a67e98a000000b004603dd3a068mr688729vso.13.1700603827816;
        Tue, 21 Nov 2023 13:57:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ+sXt9eDhCW427AVf1l7OEwets+4rFidxjW61hBhHErbUK1U+Zw/1qnAs2IyoA6SKb49c5w==
X-Received: by 2002:a67:e98a:0:b0:460:3dd3:a068 with SMTP id b10-20020a67e98a000000b004603dd3a068mr688713vso.13.1700603827569;
        Tue, 21 Nov 2023 13:57:07 -0800 (PST)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id jv24-20020a05622aa09800b00407906a4c6fsm3912537qtb.71.2023.11.21.13.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:57:07 -0800 (PST)
Message-ID: <89c13962f5502a89d48f1efb7a6203d155a7e18d.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
From:   Radu Rendec <rrendec@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Nov 2023 16:57:05 -0500
In-Reply-To: <20230629183019.1992819-2-rrendec@redhat.com>
References: <20230629183019.1992819-1-rrendec@redhat.com>
         <20230629183019.1992819-2-rrendec@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVGhvbWFzLAoKT24gVGh1LCAyMDIzLTA2LTI5IGF0IDE0OjMwIC0wNDAwLCBSYWR1IFJl
bmRlYyB3cm90ZToKPiBUaGUgRGVzaWduV2FyZSBQQ0llIGhvc3QgZHJpdmVyIHVzZXMgYSBjaGFp
bmVkIGludGVycnVwdCB0byBkZW11bHRpcGxleAo+IHRoZSBkb3duc3RyZWFtIE1TSSBpbnRlcnJ1
cHRzLiBPbiBRdWFsY29tbSBTQTg1NDBQIFJpZGUsIGVuYWJsaW5nIGJvdGgKPiBwY2llMmEgYW5k
IHBjaWUzYSBhdCB0aGUgc2FtZSB0aW1lIGNhbiBjcmVhdGUgYW4gaW50ZXJydXB0IHN0b3JtIHdo
ZXJlCj4gdGhlIHBhcmVudCBpbnRlcnJ1cHQgZmlyZXMgY29udGludW91c2x5LCBldmVuIHRob3Vn
aCByZWFkaW5nIHRoZSBQQ0llCj4gaG9zdCByZWdpc3RlcnMgZG9lc24ndCBpZGVudGlmeSBhbnkg
Y2hpbGQgTVNJIGludGVycnVwdCBzb3VyY2UuIFRoaXMKPiBlZmZlY3RpdmVseSBsb2NrcyB1cCBD
UFUwLCB3aGljaCBzcGVuZHMgYWxsIHRoZSB0aW1lIHNlcnZpY2luZyB0aGVzZQo+IGludGVycnVw
dHMuCj4gCj4gVGhpcyBpcyBhIGNsZWFyIGV4YW1wbGUgb2YgaG93IGJ5cGFzc2luZyB0aGUgaW50
ZXJydXB0IGNvcmUgYnkgdXNpbmcKPiBjaGFpbmVkIGludGVycnVwdHMgY2FuIGJlIHZlcnkgZGFu
Z2Vyb3VzIGlmIHRoZSBoYXJkd2FyZSBtaXNiZWhhdmVzLgo+IAo+IENvbnZlcnQgdGhlIGRyaXZl
ciB0byB1c2UgYSByZWd1bGFyIGludGVycnVwdCBmb3IgdGhlIGRlbXVsdGlwbGV4Cj4gaGFuZGxl
ci4gVGhpcyBhbGxvd3MgdGhlIGludGVycnVwdCBzdG9ybSBkZXRlY3RvciB0byBkZXRlY3QgdGhl
IGZhdWx0eQo+IGludGVycnVwdCBhbmQgZGlzYWJsZSBpdCwgYWxsb3dpbmcgdGhlIHN5c3RlbSB0
byBydW4gbm9ybWFsbHkuCgpLaW5kbHkgYnJpbmdpbmcgdGhlIGNoYWluZWQgaW50ZXJydXB0cyBp
c3N1ZSBiYWNrIHRvIHlvdXIgYXR0ZW50aW9uLgpMYXN0IHdlZWsgYXQgUGx1bWJlcnMsIEJyaWFu
IE1hc25leSBzcG9rZSB0byB5b3UgYWJvdXQgdGhpcywgYW5kIHlvdQphZ3JlZWQgdG8gaGF2ZSBt
ZSBzZW5kIGFub3RoZXIgcmVwbHkgdG8gdGhpcyB0aHJlYWQgdG8gYnVtcCBpdCB0byB0aGUKdG9w
IG9mIHlvdXIgaW5ib3guIEhlcmUgaXQgaXMuCgpFc3NlbnRpYWxseSwgeW91IG1hZGUgaXQgdmVy
eSBjbGVhciBpbiBhIGRpZmZlcmVudCB0aHJlYWQgWzFdIHRoYXQgeW91CndhbnRlZCB0byBnZXQg
cmlkIG9mIGNoYWluZWQgaW50ZXJydXB0cyBhbHRvZ2V0aGVyLiBIb3dldmVyLCB0aGF0IHdvdWxk
CmhhdmUgdGhlIHNpZGUgZWZmZWN0IG9mIGV4cG9zaW5nIHRoZSBwYXJlbnQgaW50ZXJydXB0IGFm
ZmluaXR5IGNvbnRyb2wKaW4gcHJvY2ZzLCB3aGljaCBpbiBNYXJjJ3Mgb3BpbmlvbiBbMl0gd291
bGQgYnJlYWsgdGhlIHVzZXJzcGFjZSBBQkkuCgpJIGRyYWZ0ZWQgYSBwcm9wb3NhbCBbM10gdGhh
dCB0cmllcyB0byBzb2x2ZSBib3RoIHByb2JsZW1zLiBCdXQgd2UKcmVhbGx5IG5lZWQgc29tZSBt
YWludGFpbmVyIGd1aWRhbmNlIGhlcmUsIHRvIGF0IGxlYXN0IGFncmVlIG9uIGEgaGlnaApsZXZl
bCBkZXNjcmlwdGlvbiBvZiB3aGF0IHRoZSBzb2x1dGlvbiB3b3VsZCBsb29rIGxpa2UuIFdvcmtp
bmcgb24KcGF0Y2hlcyB0aGF0IGdldCByZWplY3RlZCBiZWNhdXNlIHRoZSBhcHByb2FjaCBpcyBj
b25jZXB0dWFsbHkgd3JvbmcKaXMgbm90IHZlcnkgcHJhY3RpY2FsIG9yIHByb2R1Y3RpdmUuIFRo
YW5rcyBpbiBhZHZhbmNlIQoKQmVzdCByZWdhcmRzLApSYWR1CgpbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzg3N2Nzb2hjbGwuZmZzQHRnbHgvClsyXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvODc0azBiZjdmNy53bC1tYXpAa2VybmVsLm9yZy8KWzNdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8zNjVkYmI2MTkyMWZmMzc4NjJjOTE4NjJkMzFkNzVmZWMyYTUxMTg1LmNh
bWVsQHJlZGhhdC5jb20vCgo+IFNpZ25lZC1vZmYtYnk6IFJhZHUgUmVuZGVjIDxycmVuZGVjQHJl
ZGhhdC5jb20+Cj4gLS0tCj4gwqAuLi4vcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1ob3N0LmMgfCAzNSArKysrKysrKystLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jCj4gaW5kZXggOTk1MjA1N2M4ODE5
Yy4uYjYwMzc5NmQ0MTVkNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYwo+IEBAIC04MywxOCArODMsOSBAQCBpcnFyZXR1cm5f
dCBkd19oYW5kbGVfbXNpX2lycShzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApCj4gwqDCoMKgwqDCoMKg
wqDCoHJldHVybiByZXQ7Cj4gwqB9Cj4gwqAKPiAtLyogQ2hhaW5lZCBNU0kgaW50ZXJydXB0IHNl
cnZpY2Ugcm91dGluZSAqLwo+IC1zdGF0aWMgdm9pZCBkd19jaGFpbmVkX21zaV9pc3Ioc3RydWN0
IGlycV9kZXNjICpkZXNjKQo+ICtzdGF0aWMgaXJxcmV0dXJuX3QgZHdfcGNpZV9tc2lfaXNyKGlu
dCBpcnEsIHZvaWQgKmRldl9pZCkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaXJxX2No
aXAgKmNoaXAgPSBpcnFfZGVzY19nZXRfY2hpcChkZXNjKTsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgZHdfcGNpZV9ycCAqcHA7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoGNoYWluZWRfaXJxX2VudGVy
KGNoaXAsIGRlc2MpOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBwcCA9IGlycV9kZXNjX2dldF9oYW5k
bGVyX2RhdGEoZGVzYyk7Cj4gLcKgwqDCoMKgwqDCoMKgZHdfaGFuZGxlX21zaV9pcnEocHApOwo+
IC0KPiAtwqDCoMKgwqDCoMKgwqBjaGFpbmVkX2lycV9leGl0KGNoaXAsIGRlc2MpOwo+ICvCoMKg
wqDCoMKgwqDCoHJldHVybiBkd19oYW5kbGVfbXNpX2lycShkZXZfaWQpOwo+IMKgfQo+IMKgCj4g
wqBzdGF0aWMgdm9pZCBkd19wY2lfc2V0dXBfbXNpX21zZyhzdHJ1Y3QgaXJxX2RhdGEgKmQsIHN0
cnVjdCBtc2lfbXNnICptc2cpCj4gQEAgLTI1NCwyMCArMjQ1LDIxIEBAIGludCBkd19wY2llX2Fs
bG9jYXRlX2RvbWFpbnMoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQo+IMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gMDsKPiDCoH0KPiDCoAo+IC1zdGF0aWMgdm9pZCBkd19wY2llX2ZyZWVfbXNpKHN0cnVj
dCBkd19wY2llX3JwICpwcCkKPiArc3RhdGljIHZvaWQgX19kd19wY2llX2ZyZWVfbXNpKHN0cnVj
dCBkd19wY2llX3JwICpwcCwgdTMyIG51bV9jdHJscykKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKg
dTMyIGN0cmw7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBmb3IgKGN0cmwgPSAwOyBjdHJsIDwgTUFY
X01TSV9DVFJMUzsgY3RybCsrKSB7Cj4gK8KgwqDCoMKgwqDCoMKgZm9yIChjdHJsID0gMDsgY3Ry
bCA8IG51bV9jdHJsczsgY3RybCsrKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAocHAtPm1zaV9pcnFbY3RybF0gPiAwKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5kX2RhdGEocHAt
Pm1zaV9pcnFbY3RybF0sCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE5VTEwsIE5VTEwpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZnJlZV9pcnEocHAtPm1zaV9pcnFbY3RybF0sIHBwKTsKPiDC
oMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlycV9kb21haW5fcmVtb3Zl
KHBwLT5tc2lfZG9tYWluKTsKPiDCoMKgwqDCoMKgwqDCoMKgaXJxX2RvbWFpbl9yZW1vdmUocHAt
PmlycV9kb21haW4pOwo+IMKgfQo+IMKgCj4gKyNkZWZpbmUgZHdfcGNpZV9mcmVlX21zaShwcCkg
X19kd19wY2llX2ZyZWVfbXNpKHBwLCBNQVhfTVNJX0NUUkxTKQo+ICsKPiDCoHN0YXRpYyB2b2lk
IGR3X3BjaWVfbXNpX2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQo+IMKgewo+IMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX3BwKHBwKTsKPiBA
QCAtMzYxLDkgKzM1MywxNiBAQCBzdGF0aWMgaW50IGR3X3BjaWVfbXNpX2hvc3RfaW5pdChzdHJ1
Y3QgZHdfcGNpZV9ycCAqcHApCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGZvciAoY3RybCA9IDA7IGN0cmwgPCBudW1f
Y3RybHM7IGN0cmwrKykgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocHAt
Pm1zaV9pcnFbY3RybF0gPiAwKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5kX2RhdGEocHAtPm1zaV9pcnFb
Y3RybF0sCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHdf
Y2hhaW5lZF9tc2lfaXNyLCBwcCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChwcC0+bXNpX2lycVtjdHJsXSA+IDApIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJlcXVlc3RfaXJxKHBwLT5tc2lfaXJxW2N0cmxdLCBk
d19wY2llX21zaV9pc3IsIDAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9uYW1lKGRl
diksIHBwKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChyZXQpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZXF1ZXN0IGlycSAl
ZDogJWRcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBwLT5tc2lfaXJxW2N0cmxdLCByZXQp
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoF9fZHdfcGNpZV9mcmVlX21zaShwcCwgY3RybCk7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJl
dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgLyoKCg==

