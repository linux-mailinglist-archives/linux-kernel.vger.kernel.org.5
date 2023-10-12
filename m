Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203F77C6ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbjJLKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbjJLKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:16:30 -0400
Received: from qs51p00im-qukt01071501.me.com (qs51p00im-qukt01071501.me.com [17.57.155.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E779A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1697105786;
        bh=V9EwkirTajpBW1rcGjr1s3Zyrn+kckHNbCosM4ZsFO8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=JQjexNZW6zkGzBTl3aA5JuP/LjxT/w+1O1AOX0rL8/rZ8rLL/kjbpnhCGEV3zS+xK
         aAUET2/Yn1taNQrCoT1MFiXhKo4Yjwasp9d22gE24kfkV51p/qAYz2/+kObt7jKSML
         ROch8fTLo5ce/dP9bA+UsFL1TkQTxZRzsvyBz1dc6DYSXDHEBHu/symKhiBovguTMV
         Z6/yD0mTEHbKINvk96i65cTFiEdABxKSntAyqsH0kKZuK52thfOVWjJY7J0QVfNQhV
         6ZxFWx3yf17LsXsnERkTqRNLF4hLjS8DJ3BzJiSwL6XfHzaTPQFyPP14iMR2hTNdOU
         X1AOukMtq3OKQ==
Received: from fedora.fritz.box (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071501.me.com (Postfix) with ESMTPSA id 1B4741C4011E;
        Thu, 12 Oct 2023 10:16:24 +0000 (UTC)
Date:   Thu, 12 Oct 2023 12:16:21 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: fix format-truncation compiler-warning
Message-ID: <ZSfHdcCtyBe3I6Ss@fedora.fritz.box>
References: <ZSb0B+9otHhd8jCp@fedora.fritz.box>
 <ZScdgaVra/PHRRc/@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZScdgaVra/PHRRc/@gmail.com>
X-Proofpoint-ORIG-GUID: 7BAX9_0zew3GA19pg1HnOrGN_MXp-kFz
X-Proofpoint-GUID: 7BAX9_0zew3GA19pg1HnOrGN_MXp-kFz
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=507 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310120083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Oct 12, 2023 at 12:11:13AM +0200 schrieb Ingo Molnar:
> 
> Mind including the output by GCC in the changelog?
> 

Sure, let me resend the patch then :)

> ... actually needs 21+1 bytes?
> 
> Which I suppose is true - longest s64 is "-9223372036854775808"-ish, which 
> converted to the fixed-point float format above is "-9223372036854775.80": 
> 21 bytes, plus termination is another byte: 22.
> 
> Maybe put this into the changelog too, instead of relying on magic GCC 
> calculations only. :-)

I can include it as well, of course!

Mit freundlichen Grüßen / Best regards,
	Lucy
