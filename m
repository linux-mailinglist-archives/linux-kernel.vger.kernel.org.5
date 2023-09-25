Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C07AD919
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjIYN3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjIYN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:29:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9357FB8;
        Mon, 25 Sep 2023 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695648526; x=1696253326; i=w_armin@gmx.de;
 bh=CWO8T4kiHhHdhar2QuYz55rr18W5ysgSFVePDmC1eZ8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=sL1I9+tADoTgQB47LpGqIxPbZ1mT64+8GmfGijLH2bwNW7xFC/r2JaQExdWDQqN6DIIi3YWC/eg
 PKDBhadhqtQsjwzMYyrq5vUoDY7FLNNiDdq0GErYRGBD+nh0dcY+KnyMd53pZuWqbmhncNi1pVbXf
 sc/uzkCrPJ7tgs3H2c7jvVd9uvYEytmTXJxfyOsyxow7hmpwGBXzrEMAKWNpTdWYpWXBuSGMgIzbU
 YUEaeL7fhfDnDeQ3vH3ptB9xj/Apm2kpn4m0p47DGNt4lbIfHhP6BPVCbdA5i/uLZFcEZVoTAiKXN
 xWNUc0Ww0HAq28tenY6dWPvuYR2o2FZT4SgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mel3n-1rKekt2tyn-00aiz1; Mon, 25 Sep 2023 15:28:46 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] platform/x86: Fix reference leaks
Date:   Mon, 25 Sep 2023 15:28:42 +0200
Message-Id: <20230925132844.72479-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tnhX8hNAv2gwyG/OIoIMe5O4n1Cf+tiVydD5wfd3+zTfSVCp2At
 xuUJfvOzk1I2mzUmKYv3ni96HN0gsInyOOw+zKWEP5t+tt9O0j2r9aNNR6920/ztwSqk03O
 KkoZHSfk2X9Qu2Tvz8OYHjEBXDbA4Yh2QG0kC8U2vw2qvkJocd9e/fWTMUThW6o9kClDGvv
 csV0fgBoDgLb+VBA9IeQA==
UI-OutboundReport: notjunk:1;M01:P0:HhaFlpIL7gg=;afsaFn/AJccQrwOI/JVAxafSbnW
 VcfkMswN4NZV9V6W2VvjvHr5qKL0SOovqTQd/8FhW9y6Ho8qGCYpcpHixd8512cMZ7zKFNqqs
 CgEEH1SbMuf1f2CUHya/EKZQxA6qSXWC5juGAmEJSWULdhDD3X1UWjSWgssbAMZsmfiqNW3xg
 koy4jZkRgMfPYC3vDLvv19C9671tdNLcxDUqq+mrqv+BQjDwFX0DLSBcW1RxWJgAp2/YmrYJl
 2D3T1ct48Hc8U8E2ovBi5iPSFt3jOyJPgoghhabkrC/FaOZ/vqIkRrcZSgUiebEL8+xe1CNYh
 xTQ9EzvoFCTlemBi7vbDcWvshT79ZW1DH6Zfpq4HHLXBuQqhRHwR+5PWNLerMOBLk6D6/qc0i
 wkcgd/gU4ph0/oFXx7PWKT/UBuDt0ekLX8C9nhdITTpa10bv1uc9BV6kSvf40kbZDjkh9qLYK
 AGBEP0q59Fs6uIZb2OIJ4Hc1K73RdZRZUbrMBwJ/noSHczAQZRBbrdK58LsHDbto+Tpmh3WeY
 CaZt9KNVtjKx+eCHbrG1fxnk5pm1tVhiB2HYBNldxQEhUFFC5u0Wov40ryzFl9DTp/pDXNChC
 5QJDOqrH0jOXxRHQ0v+H7gU1v4Jeop5wC3DXKipOVS6G0OpgPXYlt0K2mlCdwnCKUI4Dyb7Cm
 ydJDQi8O6Y6VHEslhLgvhlItXtHw2gQTA4iuu3DuDmePD6YjpJrbwJ6kh5AL4Hc4O8/AHgatM
 mzcn3P5AlFfmdeVMYklKfUvPXlGYvFi0JP1ARbH26cPArjuSLPitvTIur76NO1aIIgOR33E7w
 JLhIFjo7fcPzPRib9Mw8EILijM5iQkRPAWxR5UFyR0qi0GOsmgCl8dUIAH9zooslbP1uri1vY
 eTWhTWnCU8szt+47F8mhtdqG8zhYHbFN2BRfA9KmpACQTBTbqpnezTFtd6lUMDvuk7I1Cj/BS
 uGcDGcyLjoofe09fir4RHTxPJ0M=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a duplicate attribute is found using kset_find_obj(), a reference
to that attribute is returned which needs to be disposed accordingly
using kobject_put(). This issue likely first appeared inside the
dell-wmi-sysman driver, see
commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak").
However, it also seems that the bug was copied from this driver into
the think-lmi and hp-bioscfg drivers. Maybe a more abstract
fw_attr_class could prevent such issues in the future by abstracting
away the kobject handling?

Armin Wolf (2):
  platform/x86: think-lmi: Fix reference leak
  platform/x86: hp-bioscfg: Fix reference leak

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++++----
 drivers/platform/x86/think-lmi.c             | 24 ++++++++++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

=2D-
2.39.2

