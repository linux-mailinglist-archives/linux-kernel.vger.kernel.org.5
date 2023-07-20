Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC075A6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGTGk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGTGkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:40:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8392D4E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:40:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-577323ba3d5so25778737b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689835196; x=1690439996;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqyBwYcbKCWrE+16W+dtidCOefNt3yC66lUvAXJt1+s=;
        b=IlTKnP6Hl3Uub4PdrzLciuVSeDE8WsRXahT7kfpq0odCgAnJWCMHF979FftsDo5mMe
         SoAunJVXgM3wrjDRvaR7UCvHnidfSONnnormq22bhHGlj4n1M88NakgAfG1o44iJDWIC
         GjQQPGWkYthFqwnfYEAxYf//QexU1tgz2GwPAD4d7rulKOIx5o7dlACHv+Xn6iRBiK2H
         BVP+hxhLpvvYvcaSlzQOaACvy56RrzNES6NqJO1v+CPq7iWAOPjCRgGeTHfHuVnKhMUO
         ESKFVjhglV1S/+YlnMJIxRe1Ymnn2soaXjiJnIwFYFm8d0zpu5vFCREpJidLH6bmzEtn
         fyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835196; x=1690439996;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqyBwYcbKCWrE+16W+dtidCOefNt3yC66lUvAXJt1+s=;
        b=lZTUTElUrUygyLeqgTqr41JVPPorL+LdDtwc06CcVEick37nNah/HNoJX2ucIL7Ooj
         bNa2dSL9+QBe5jC6zitI8V+u0U33w7WXuV0JO+e+nfSmLKdIQ5X3oNOM/rSR68Dz4Ixo
         ZFp7KNg6XnMuHOYFstDGxnzDLuUCcANF59WsKExKTlHUbiVEH/1Ds0ECI+vvBpwJA+3o
         HYc0FI2EA4UU4XBc55YoqEwOZg/gOVTEmi8tr2rVf2RALQCrkM+WRpx7hV6GSDWmCBIx
         e8arp6otLpLZda/hQb6ckMgkQFGDE9hukBm4oJTUbsUBCX41nW5nbmDIk9gYOvnZJ6wX
         ZzpQ==
X-Gm-Message-State: ABy/qLab8pDkTDJrblyRB/s+ZnJdPXoHu0BtPoJgif51LHsc6qdV33ae
        XDnii4UVc3aCAds5pymvD6islFhLDMn0gA==
X-Google-Smtp-Source: APBJJlHuCryQlJRgEDCsmhuDwUEpc3ubbxZJg09h56NXa82UbZtshW62Nzs3H+ZzSMedGeoEDaCwoP1RGJuacw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:dd2:b0:577:6462:24c3 with SMTP
 id db18-20020a05690c0dd200b00577646224c3mr84157ywb.4.1689835195982; Wed, 19
 Jul 2023 23:39:55 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:38:51 +0800
Mime-Version: 1.0
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
Subject: [PATCH 0/3] rust: kunit: Support KUnit tests with a user-space like syntax
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     David Gow <davidgow@google.com>,
        "=?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was originally written by Jos=C3=A9 Exp=C3=B3sito, and can be f=
ound
here:
https://github.com/Rust-for-Linux/linux/pull/950

Add support for writing KUnit tests in Rust. While Rust doctests are
already converted to KUnit tests and run, they're really better suited
for examples, rather than as first-class unit tests.

This series implements a series of direct Rust bindings for KUnit tests,
as well as a new macro which allows KUnit tests to be written using a
close variant of normal Rust unit test syntax. The only change required
is replacing '#[cfg(test)]' with '#[kunit_tests(kunit_test_suite_name)]'

An example test would look like:
	#[kunit_tests(rust_kernel_hid_driver)]
	mod tests {
	    use super::*;
	    use crate::{c_str, driver, hid, prelude::*};
	    use core::ptr;

	    struct SimpleTestDriver;
	    impl Driver for SimpleTestDriver {
	        type Data =3D ();
	    }

	    #[test]
	    fn rust_test_hid_driver_adapter() {
	        let mut hid =3D bindings::hid_driver::default();
	        let name =3D c_str!("SimpleTestDriver");
	        static MODULE: ThisModule =3D unsafe { ThisModule::from_ptr(ptr::n=
ull_mut()) };

        	let res =3D unsafe {
	            <hid::Adapter<SimpleTestDriver> as driver::DriverOps>::registe=
r(&mut hid, name, &MODULE)
	        };
	        assert_eq!(res, Err(ENODEV)); // The mock returns -19
	    }
	}

Changes since the GitHub PR:
- Rebased on top of kselftest/kunit
- Add const_mut_refs feature
  This may conflict with https://lore.kernel.org/lkml/20230503090708.252431=
0-6-nmi@metaspace.dk/
- Add rust/macros/kunit.rs to the KUnit MAINTAINERS entry

Signed-off-by: David Gow <davidgow@google.com>
---
Jos=C3=A9 Exp=C3=B3sito (3):
      rust: kunit: add KUnit case and suite macros
      rust: macros: add macro to easily run KUnit tests
      rust: kunit: allow to know if we are in a test

 MAINTAINERS          |   1 +
 rust/kernel/kunit.rs | 181 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/lib.rs   |   1 +
 rust/macros/kunit.rs | 149 ++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 +++++++++
 5 files changed, 361 insertions(+)
---
base-commit: 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
change-id: 20230720-rustbind-477964954da5

Best regards,
--=20
David Gow <davidgow@google.com>

