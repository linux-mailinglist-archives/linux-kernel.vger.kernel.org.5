Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73E793FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbjIFPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbjIFPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:08:00 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1E094;
        Wed,  6 Sep 2023 08:07:55 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Aa5Q2028372;
        Wed, 6 Sep 2023 15:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=bUaqSbvKYJBuc89xVN5Q+vh9RQ/KMwEGjBlfFXomo7o=;
 b=EXBmq3pg58j143eDb51AkaSH8MAgUblSNoOCwZ+ySWas9VBYA2id6Pv2SQa6OBYSzAJ1
 iikU10dbWXdH7fy3pL2T5O+F05RFerLeu1Hcj1XXyssE5vvNcSy6/0H6FsgFhQNevHfj
 hxp1tXVpGnAbAIonGiHHjyCRsgJgSkwlji5HM1BYuWIkykYErezZwfUUZNBgDwUYuPer
 XKcOTXFNoOjFdazXXPTkTtX+Dql6/J4AauvD9+uea0TmRS7BgabbE2/fdu6kMgPpVs36
 9h0fVfz58LC4jApB2S2dlNSFvaSMBa00kLRW7QnhBYLEPPIx+0Tn5yn47yXdmOqaxEML jw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sxqtmt6gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 15:07:08 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5E4FE80044C;
        Wed,  6 Sep 2023 15:07:07 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 116868091C6;
        Wed,  6 Sep 2023 15:07:05 +0000 (UTC)
Date:   Wed, 6 Sep 2023 10:07:03 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Justin Stitt <justinstitt@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
Message-ID: <ZPiVhvsoUzvG6wOs@swahl-home.5wahls.com>
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
 <ZPhsSzHG6YMViOSk@gmail.com>
 <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
 <ZPiH/ds9oeimXDdb@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPiH/ds9oeimXDdb@gmail.com>
X-Proofpoint-ORIG-GUID: npZ9-KAuf7hrlBz-ckG1zphUc7Lm1OjF
X-Proofpoint-GUID: npZ9-KAuf7hrlBz-ckG1zphUc7Lm1OjF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:09:01PM +0200, Ingo Molnar wrote:
> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > Hi Ingo,
> > 
> > On 9/6/23 14:10, Ingo Molnar wrote:
> > > 
> > > * Justin Stitt <justinstitt@google.com> wrote:
> > > 
> > >> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> > >> destination strings [1].
> > >>
> > >> We can see that `arg` and `uv_nmi_action` are expected to be
> > >> NUL-terminated strings due to their use within `strcmp()` and format
> > >> strings respectively.
> > >>
> > >> With this in mind, a suitable replacement is `strscpy` [2] due to the
> > >> fact that it guarantees NUL-termination on its destination buffer
> > >> argument which is _not_ the case for `strncpy` or `strcpy`!
> > >>
> > >> In this case, we can drop both the forced NUL-termination and the `... -1` from:
> > >> |       strncpy(arg, val, ACTION_LEN - 1);
> > >> as `strscpy` implicitly has this behavior.
> > >>
> > >> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> > >> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > >> Link: https://github.com/KSPP/linux/issues/90
> > >> Cc: linux-hardening@vger.kernel.org
> > >> Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > 
> > >>  arch/x86/platform/uv/uv_nmi.c | 7 +++----
> > >>  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > Note that this commit is already upstream:
> > > 
> > >   1e6f01f72855 ("x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()")
> > > 
> > > Below is the delta your v3 patch has compared to what is upstream - is it 
> > > really necessary to open code it, instead of using strnchrnul() as your 
> > > original patch did? Am I missing anything here?
> > 
> > The new version is a result of a review from my because IMHO:
> > 
> > 	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
> > 
> > Is really unreadable / really hard to reason about if
> > this is actually correct and does not contain any
> > of by 1 bugs.
> > 
> > Note that the diff of v3 compared to the code before v2 landed is
> > actually smaller now and actually matches the subject of:
> > "refactor deprecated strcpy and strncpy"
> > 
> > Where as v2 actually touches more code / refactor things
> > which fall outside of a "one change per patch" approach.
> > The:
> > 
> > 	p = strchr(arg, '\n');
> > 	if (p)
> > 		*p = '\0';
> > 
> > was already there before v2 landed.
> > 
> > I also suggested to do a follow up patch to change things to:
> > 
> > 	strscpy(arg, val, sizeof(arg));
> > 	p = strchrnul(arg, '\n');
> > 	*p = '\0';
> > 
> > Which IMHO is much more readable then what has landed
> > now. But since v2 has already landed I guess the best
> > thing is just to stick with what we have upstream now...
> 
> Well, how about we do a delta patch with all the changes
> you suggested? I'm all for readability.

For whatever it's worth, I vote in favor of adopting an increased
readability version.

I was on vacation when the patch came through, and by the time I
reviewed it it was already accepted.  I still puzzled through the
-1/+1 stuff to be sure it functioned correctly; since it worked and
was already accepted, I let it go.

When Hans' comments on readability later came through, I was thinking
"Yes, he's exactly right! Why, when I worked so hard on verifying that
the code worked properly, did it not occur to me to suggest re-writing
this in a simpler fashion to make the intent clear?"

Thanks,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
