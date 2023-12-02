Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7A801D03
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjLBNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:20:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C391F3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 05:20:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cde104293fso2590760b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701523248; x=1702128048; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38eV0LKdNi3TITjOGB0YU27nx54Nu5BIRGcEBAMr+DY=;
        b=nU4OdBVYi+M3f4g0QhQpZCbelDpKcNzM1VuYqPssUwiZ+6eufQ3T4XarWstqP1GIWE
         4s3x+pZ5ugnWHr4UQGkLLRToO+RW6dvVHZNMTn3avOzNdQJAwQTFyX3jNr0oQ9sHyowT
         eWHXVqII7zdbPVL6NSOPYwzYBBrqWn6hZ6ZjUgBFe6NtV3Z4mqWHNY8JECpz7oHOoJbF
         sWSh8X4dJ8s+ohZN8KWuNmV0hHeHsu2k/QPBVnaB8FOR8wgcnnKZPKNUgoxTa53pgfmv
         t4A5uiA+NiHJLnLtjWQ2jyzuSqneC7FWiDjNOupC0EZNuYunQcjFJgHL3wUWS6rRUeCW
         Jx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701523248; x=1702128048;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38eV0LKdNi3TITjOGB0YU27nx54Nu5BIRGcEBAMr+DY=;
        b=lNb7BbYxqYJb4HtGwTXNU/7ACpCXdkR4b4bjie5ddqLbY6ttLqTL3D2ioGVMI9VimC
         zmRmperAchRmdp1E00QAH9UYZ3SDD7rpeJFF8ScqJqTbDIS4FIyxsibvkLOMwn4JB4Dp
         ObpMK8w5+0eszmYDEP7fe4XAcfc1KVRZSVWLEfvATDiooE+J6K1iWeROPzvHwu/fl0GW
         1lSLz9ydXDhavybC9Y1/bQNQlQG80W3ccZdXMfj5VnK/9/inrgWcMdpCXWphqeO3BH/O
         r1x1bmAX96v0p7w5ecmm0ocKcvJ2x5597YGDnOKIArLDxQ9PmarFx1FhCTqTF2yZwAUq
         i38A==
X-Gm-Message-State: AOJu0YxXpVNSQ59xC5HeLw6cPzFdhYtvhIPs6C/1kGbMCFdm9fkdHgVl
        ytQL0Gbg9vucUWm/CN/yRSET7w==
X-Google-Smtp-Source: AGHT+IEzgP87enLKzkmPs6y8qDB6CMCPP38yBGAzMauITYCVSxePOcsnUgMZlQEjr/wK10DVgz7vOg==
X-Received: by 2002:a05:6a00:2a09:b0:6bd:9281:9453 with SMTP id ce9-20020a056a002a0900b006bd92819453mr483081pfb.9.1701523247890;
        Sat, 02 Dec 2023 05:20:47 -0800 (PST)
Received: from ?IPv6:2402:7500:4d5:3c6d:245f:1df8:d6c0:9d2d? ([2402:7500:4d5:3c6d:245f:1df8:d6c0:9d2d])
        by smtp.gmail.com with ESMTPSA id e2-20020a635442000000b005bdd8dcfe19sm4614743pgm.10.2023.12.02.05.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Dec 2023 05:20:47 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 07/13] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231129201601.GA1174@sol.localdomain>
Date:   Sat, 2 Dec 2023 21:20:42 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67F5B520-ED93-4CF2-AACB-D0B64F5B38A1@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-8-jerry.shih@sifive.com>
 <20231128040716.GI1463@sol.localdomain>
 <7DFBB20D-B8D4-409B-8562-4C60E67FD279@sifive.com>
 <20231129201601.GA1174@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2023, at 04:16, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Nov 29, 2023 at 03:57:25PM +0800, Jerry Shih wrote:
>> On Nov 28, 2023, at 12:07, Eric Biggers <ebiggers@kernel.org> wrote:
>>> On Mon, Nov 27, 2023 at 03:06:57PM +0800, Jerry Shih wrote:
>>>> +typedef void (*aes_xts_func)(const u8 *in, u8 *out, size_t length,
>>>> +			     const struct crypto_aes_ctx *key, u8 *iv,
>>>> +			     int update_iv);
>>>=20
>>> There's no need for this indirection, because the function pointer =
can only have
>>> one value.
>>>=20
>>> Note also that when Control Flow Integrity is enabled, assembly =
functions can
>>> only be called indirectly when they use SYM_TYPED_FUNC_START.  =
That's another
>>> reason to avoid indirect calls that aren't actually necessary.
>>=20
>> We have two function pointers for encryption and decryption.
>> 	static int xts_encrypt(struct skcipher_request *req)
>> 	{
>> 		return xts_crypt(req, =
rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt);
>> 	}
>>=20
>> 	static int xts_decrypt(struct skcipher_request *req)
>> 	{
>> 		return xts_crypt(req, =
rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt);
>> 	}
>> The enc and dec path could be folded together into `xts_crypt()`, but =
we will have
>> additional branches for enc/decryption path if we don't want to have =
the indirect calls.
>> Use `SYM_TYPED_FUNC_START` in asm might be better.
>>=20
>=20
> Right.  Normal branches are still more efficient and straightforward =
than
> indirect calls, though, and they don't need any special considerations =
for CFI.
> So I'd just add a 'bool encrypt' or 'bool decrypt' argument to =
xts_crypt(), and
> make xts_crypt() call the appropriate assembly function based on that.

Fixed.
The xts_crypt() now has an additional bool argument for enc/decryption.

>>> Did you consider writing xts_crypt() the way that arm64 and x86 do =
it?  The
>>> above seems to reinvent sort of the same thing from first =
principles.  I'm
>>> wondering if you should just copy the existing approach for now.  =
Then there
>>> would be no need to add the scatterwalk_next() function, and also =
the handling
>>> of inputs that don't need ciphertext stealing would be a bit more =
streamlined.
>>=20
>> I will check the arm and x86's implementations.
>> But the `scatterwalk_next()` proposed in this series does the same =
thing as the
>> call `scatterwalk_ffwd()` in arm and x86's implementations.
>> The scatterwalk_ffwd() iterates from the beginning of =
scatterlist(O(n)), but the=20
>> scatterwalk_next() is just iterates from the end point of the last =
used
>> scatterlist(O(1)).
>=20
> Sure, but your scatterwalk_next() only matters when there are multiple
> scatterlist entries and the AES-XTS message length isn't a multiple of =
the AES
> block size.  That's not an important case, so there's little need to
> micro-optimize it.  The case that actually matters for AES-XTS is a =
single-entry
> scatterlist containing a whole number of AES blocks.

The v3 patch will remove the `scatterwalk_next()` and use =
`scatterwalk_ffwd()`
instead.

-Jerry=
