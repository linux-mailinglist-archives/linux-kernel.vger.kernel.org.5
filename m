Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B037F8819
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjKYDWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:22:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F391998;
        Fri, 24 Nov 2023 19:22:52 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a0b7f793b8aso20395666b.2;
        Fri, 24 Nov 2023 19:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700882571; x=1701487371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rMvToBJHCipDORTIOSmsVjLY4hgs4GLBlWC934vVrzc=;
        b=Z2gjmPrR3i8u5WyiPBeURBcjuK4mjdS5RiPY86krSs92DWvPXIDeWqk8Ta3AU2LmPk
         oLRhEWcQCKNhRof4skVb/FBTUz37eDYTlDmgQIIGQdlFC5vAjNNE/1KiXFhYORALiOvu
         FBBEwEiNEI4AQcka2Ot5/Y4RvDWjz12qvUbsV+2kxrcutZCPLJSJi3dl2AsyZtPnz/Ha
         R98FO0w37fcZcuO0ugnLKBD8U7AQEEYBon40F/qrDU57HjUCBvzVOCND9JIU/nL3CJQP
         uNJ4bb41iXZAZbkhpf0sq/8VfYId9LDkXriHkXAB23nMqLU/ReuIW37w4wDhWaru8joi
         cIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700882571; x=1701487371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMvToBJHCipDORTIOSmsVjLY4hgs4GLBlWC934vVrzc=;
        b=wQqXFhCYq4PjRghxhRHJpFiVrxQG4ZF6V/fWOIORPz8CObFxE3t7rISPYv1wh1Kezd
         S3ADgeunO6pid9S9N52R3QMxJJGVBsvfQsRzNImrX+MGw5QRS6IHwbK45iz8FCAbu6r3
         hYsTxzdq/BQdI5Jldmvcr7JMPTkCCOwN47HGBvfxK75qaK5HRZraZE+SHwiWJyHrLAy1
         hBFmt7dRiAN4RoogOabZ3NQC1z9pWP2exNrGD9zm3LVAJ/bngev1S4H1IX5ERJGyDkcq
         e2ejEtv5vmioqPIsmrJ6ZelgwEAFbA9rgZRpOyyy9/7zjSaRUJE5pb/sx9pXcmjhQiXF
         WD0w==
X-Gm-Message-State: AOJu0Yz5o09sxXGHLhDicr5HkBt4Xmy1Rlfjb29MfGQodxzRyD8H1JYl
        Zol6wJfXZm6f2pPdRTAavpBafHDsmpXJ+dUbb5vPsUnXMaQ=
X-Google-Smtp-Source: AGHT+IHkpXh00aL/cocbpA6FOs1F7LUQxGBtokQTch4F8X+lauAEIG2RpTTtI60T13UAUS6jKaHAw+Y5LcWELCu8Us0=
X-Received: by 2002:a17:906:3787:b0:a02:9700:bf53 with SMTP id
 n7-20020a170906378700b00a029700bf53mr3599111ejc.46.1700882570638; Fri, 24 Nov
 2023 19:22:50 -0800 (PST)
MIME-Version: 1.0
References: <1297339.1700862676@warthog.procyon.org.uk> <1335877.1700868425@warthog.procyon.org.uk>
In-Reply-To: <1335877.1700868425@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 24 Nov 2023 21:22:38 -0600
Message-ID: <CAH2r5muRJqefiMiJwKdUJZp4HMprJYCCRNSzMysCUizikQC+UA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Set the file size after doing copychunk_range
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006d8c61060af19511"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006d8c61060af19511
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

updated


On Fri, Nov 24, 2023 at 5:27=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> David Howells <dhowells@redhat.com> wrote:
>
> > +     truncate_inode_pages_range(&target_inode->i_data, destoff, len);
>
> That should actually be:
>
>         truncate_inode_pages_range(&target_inode->i_data, destoff, destof=
f + len);
>
> David
>
>


--=20
Thanks,

Steve

--0000000000006d8c61060af19511
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-Set-the-file-size-after-doing-copychunk_range.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-Set-the-file-size-after-doing-copychunk_range.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpdhjyx10>
X-Attachment-Id: f_lpdhjyx10

RnJvbSBjNjAwOGFkMjM0MjJjMGEyOWQxYmExNzU5MDVjZDhhMDJiNWRmNWI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBGcmksIDI0IE5vdiAyMDIzIDIxOjUxOjE2ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gY2lm
czogU2V0IHRoZSBmaWxlIHNpemUgYWZ0ZXIgZG9pbmcgY29weWNodW5rX3JhbmdlCgpTZXQgaV9z
aXplIG9uIHRoZSBpbm9kZSBhZnRlciBkb2luZyB0aGUgY29weWNodW5rX3JhbmdlIG9wZXJhdGlv
biBhcyB0aGlzCnZhbHVlIG1heSBiZSB1c2VkIGJ5IHZhcmlvdXMgdGhpbmdzIGludGVybmFsbHku
ICBzdGF0KCkgaGlkZXMgdGhlIGlzc3VlCmJlY2F1c2Ugc2V0dGluZyAtPnRpbWUgdG8gMCBjYXVz
ZXMgY2lmc19nZXRhdHIoKSB0byByZXZhbGlkYXRlIHRoZQphdHRyaWJ1dGVzLgoKQWxzbyByZWR1
Y2UgdGhlIHBhZ2VjYWNoZSB0cnVuY2F0aW9uIHRvIG9ubHkgaW52YWxpZGF0ZSB0aGUgcmFuZ2Ug
b2YgYnl0ZXMKdGhhdCB3aWxsIGJlIGNvcGllZCBvdmVyIG90aGVyd2lzZSB3ZSB3aWxsIGRpc2Nh
cmQgZGlydHkgZGF0YSB0aGF0IGlzbid0Cmluc2lkZSB0aGUgdGFyZ2V0IHJhbmdlLgoKRml4ZXM6
IDYyMGQ4NzQ1YjM1ZCAoIkludHJvZHVjZSBjaWZzX2NvcHlfZmlsZV9yYW5nZSgpIikKQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogRGF2aWQgSG93ZWxscyA8ZGhvd2Vs
bHNAcmVkaGF0LmNvbT4KY2M6IFNoeWFtIFByYXNhZCBOIDxuc3BtYW5nYWxvcmVAZ21haWwuY29t
PgpjYzogUm9oaXRoIFN1cmFiYXR0dWxhIDxyb2hpdGhzLm1zZnRAZ21haWwuY29tPgpjYzogSmVm
ZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNo
IDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQvY2lmc2ZzLmMgfCA3
ICsrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jaWZzZnMuYyBiL2ZzL3NtYi9jbGllbnQvY2lm
c2ZzLmMKaW5kZXggZWEzYTdhNjY4YjQ1Li5mODQ1ZTczNWYxMTYgMTAwNjQ0Ci0tLSBhL2ZzL3Nt
Yi9jbGllbnQvY2lmc2ZzLmMKKysrIGIvZnMvc21iL2NsaWVudC9jaWZzZnMuYwpAQCAtMTMwNywx
MiArMTMwNywxNSBAQCBzc2l6ZV90IGNpZnNfZmlsZV9jb3B5Y2h1bmtfcmFuZ2UodW5zaWduZWQg
aW50IHhpZCwKIAkJZ290byB1bmxvY2s7CiAKIAkvKiBzaG91bGQgd2UgZmx1c2ggZmlyc3QgYW5k
IGxhc3QgcGFnZSBmaXJzdCAqLwotCXRydW5jYXRlX2lub2RlX3BhZ2VzKCZ0YXJnZXRfaW5vZGUt
PmlfZGF0YSwgMCk7CisJdHJ1bmNhdGVfaW5vZGVfcGFnZXNfcmFuZ2UoJnRhcmdldF9pbm9kZS0+
aV9kYXRhLCBkZXN0b2ZmLCBkZXN0b2ZmICsgbGVuKTsKIAogCXJjID0gZmlsZV9tb2RpZmllZChk
c3RfZmlsZSk7Ci0JaWYgKCFyYykKKwlpZiAoIXJjKSB7CiAJCXJjID0gdGFyZ2V0X3Rjb24tPnNl
cy0+c2VydmVyLT5vcHMtPmNvcHljaHVua19yYW5nZSh4aWQsCiAJCQlzbWJfZmlsZV9zcmMsIHNt
Yl9maWxlX3RhcmdldCwgb2ZmLCBsZW4sIGRlc3RvZmYpOworCQlpZiAocmMgPiAwICYmIGRlc3Rv
ZmYgKyByYyA+IGlfc2l6ZV9yZWFkKHRhcmdldF9pbm9kZSkpCisJCQl0cnVuY2F0ZV9zZXRzaXpl
KHRhcmdldF9pbm9kZSwgZGVzdG9mZiArIHJjKTsKKwl9CiAKIAlmaWxlX2FjY2Vzc2VkKHNyY19m
aWxlKTsKIAotLSAKMi4zOS4yCgo=
--0000000000006d8c61060af19511--
