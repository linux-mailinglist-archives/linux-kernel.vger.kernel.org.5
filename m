Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76D87BBE05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjJFRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjJFRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:51:34 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB6BE;
        Fri,  6 Oct 2023 10:51:32 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id fe1c702b030d306b; Fri, 6 Oct 2023 19:51:31 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E4A8F665D08;
        Fri,  6 Oct 2023 19:51:30 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 0/6] thermal: core: Pass trip pointers to governor .throttle() callbacks
Date:   Fri, 06 Oct 2023 19:38:28 +0200
Message-ID: <13365827.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgu
 rhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

While working on https://lore.kernel.org/linux-pm/4846448.GXAFRqVoOG@kreacher/
I started to change thermal governors so as to reduce the usage of trip
indices in them.  At that time, I was concerned that they could not be
replaced with trip pointers overall, because they were needed in certain
situations (tracing, debug messages, userspace governor) and computing them
whenever they were needed would be extra overhead with relatively weak
justification.  In the meantime, however, I realized that for a given trip
pointer, it is actually trivial to compute the corresponding index: it is
sufficient to subtract the start of the trips[] table in the thermal zone
containing the trip from that trip pointer for this purpose.  Patch [1/6]
modifies thermal_zone_trip_id() in accordance with this observation.

Now that the cost of computing a trip index for a given trip pointer and
thermal zone is not a concern any more, the governors can be generally
switched over to using trip pointers for representing trips.  One of the
things they need to do sometimes, though, is to iterate over trips in a
given thermal zone (the core needs to do that too, of course) and
for_each_thermal_trip() is somewhat inconvenient for this purpose, because
it requires callback functions to be defined and in some cases new data
types need to be introduced just in order to use it.  For this reason,
patch [2/6] adds a macro for iterating over trip points in a given thermal
zone with the help of a trip pointer and changes for_each_thermal_trip() to
use that macro internally.

Patches [3-5/6] change individual governors to prepare them for using trip
pointers everywhere for representing trips, except for the trip argument of
the .throttle() callback and patch [6/6] finally changes the .throttle()
callback definition so that it takes a trip pointer as the argument
representing the trip.

Please refer to the individual patch changelogs for details.

Thanks!



