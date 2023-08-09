Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88501775DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjHILm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjHILm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:42:27 -0400
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF71FDE;
        Wed,  9 Aug 2023 04:42:26 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 305C760C77;
        Wed,  9 Aug 2023 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1691581345;
        bh=GDaLVaPXx2Q25V9NYICBLSe0SlI0oGLlwVqyrK2CsnY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From;
        b=L+Mkpu5mALetfMQBMe4EWq+5Nem8m5z0geBer9lwAF0d7xlir1FrBZW7eLNw90lVa
         esHAUQIAdyFQ9htUftScpywcG/lMahiiP8h9XQG6tN2OkSg1lMLlV42/3rAbLH2Ec4
         1PCX7WDGBJyV3M/Spi3azkmia9w2be+SKY3Pk4pjYy8Trzl0tIpf+PvQTS3znIiU1T
         ZiEvpMPj6GD92YazKMy5rGvcd0AC58/A5C3i009seJGcOyqRQGuLJNH17FLKm9ZVnw
         r64d+NUxjGqV3aM+48PiE8n63bt85Hs3D9riDlFK1nTuE57LBpY8S1IZiBv9Q6psMO
         ymVP5r9Um/tNA==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 2B369145D38; Wed,  9 Aug 2023 13:42:57 +0200 (SAST)
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Kolpackov <boris@codesynthesis.com>
Subject: [PATCH v3 1/1] kconfig: port qconf to work with Qt6 in addition to Qt5
Date:   Wed,  9 Aug 2023 13:42:31 +0200
Message-Id: <20230809114231.2533523-2-boris@codesynthesis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230809114231.2533523-1-boris@codesynthesis.com>
References: <20230809114231.2533523-1-boris@codesynthesis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5
are no longer guaranteed to work.

Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>
---
 scripts/kconfig/qconf-cfg.sh | 25 +++++++++++++++-------
 scripts/kconfig/qconf.cc     | 40 +++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
index 117f36e56..0e113b0f2 100755
--- a/scripts/kconfig/qconf-cfg.sh
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -5,7 +5,8 @@ cflags=$1
 libs=$2
 bin=$3
 
-PKG="Qt5Core Qt5Gui Qt5Widgets"
+PKG5="Qt5Core Qt5Gui Qt5Widgets"
+PKG6="Qt6Core Qt6Gui Qt6Widgets"
 
 if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
 	echo >&2 "*"
@@ -14,16 +15,26 @@ if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
 	exit 1
 fi
 
-if ${HOSTPKG_CONFIG} --exists $PKG; then
-	${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
-	${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
+if ${HOSTPKG_CONFIG} --exists $PKG6; then
+	${HOSTPKG_CONFIG} --cflags ${PKG6} > ${cflags}
+	# Qt6 requires C++17.
+	echo -std=c++17 >> ${cflags}
+	${HOSTPKG_CONFIG} --libs ${PKG6} > ${libs}
+	${HOSTPKG_CONFIG} --variable=libexecdir Qt6Core > ${bin}
+	exit 0
+fi
+
+if ${HOSTPKG_CONFIG} --exists $PKG5; then
+	${HOSTPKG_CONFIG} --cflags ${PKG5} > ${cflags}
+	${HOSTPKG_CONFIG} --libs ${PKG5} > ${libs}
 	${HOSTPKG_CONFIG} --variable=host_bins Qt5Core > ${bin}
 	exit 0
 fi
 
 echo >&2 "*"
-echo >&2 "* Could not find Qt5 via ${HOSTPKG_CONFIG}."
-echo >&2 "* Please install Qt5 and make sure it's in PKG_CONFIG_PATH"
-echo >&2 "* You need $PKG"
+echo >&2 "* Could not find Qt6 or Qt5 via ${HOSTPKG_CONFIG}."
+echo >&2 "* Please install Qt6 or Qt5 and make sure it's in PKG_CONFIG_PATH"
+echo >&2 "* You need $PKG6 for Qt6"
+echo >&2 "* You need $PKG5 for Qt5"
 echo >&2 "*"
 exit 1
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 78087b2d9..3a4d7a19e 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -5,10 +5,11 @@
  */
 
 #include <QAction>
+#include <QActionGroup>
 #include <QApplication>
 #include <QCloseEvent>
 #include <QDebug>
-#include <QDesktopWidget>
+#include <QScreen>
 #include <QFileDialog>
 #include <QLabel>
 #include <QLayout>
@@ -17,6 +18,7 @@
 #include <QMenuBar>
 #include <QMessageBox>
 #include <QToolBar>
+#include <QRegularExpression>
 
 #include <stdlib.h>
 
@@ -1126,7 +1128,7 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 
 QString ConfigInfoView::print_filter(const QString &str)
 {
-	QRegExp re("[<>&\"\\n]");
+	QRegularExpression re("[<>&\"\\n]");
 	QString res = str;
 	for (int i = 0; (i = res.indexOf(re, i)) >= 0;) {
 		switch (res[i].toLatin1()) {
@@ -1322,15 +1324,15 @@ ConfigMainWindow::ConfigMainWindow(void)
 	int width, height;
 	char title[256];
 
-	QDesktopWidget *d = configApp->desktop();
 	snprintf(title, sizeof(title), "%s%s",
 		rootmenu.prompt->text,
 		""
 		);
 	setWindowTitle(title);
 
-	width = configSettings->value("/window width", d->width() - 64).toInt();
-	height = configSettings->value("/window height", d->height() - 64).toInt();
+	QRect g = configApp->primaryScreen()->geometry();
+	width = configSettings->value("/window width", g.width() - 64).toInt();
+	height = configSettings->value("/window height", g.height() - 64).toInt();
 	resize(width, height);
 	x = configSettings->value("/window x");
 	y = configSettings->value("/window y");
@@ -1379,17 +1381,17 @@ ConfigMainWindow::ConfigMainWindow(void)
 		this, &ConfigMainWindow::goBack);
 
 	QAction *quitAction = new QAction("&Quit", this);
-	quitAction->setShortcut(Qt::CTRL + Qt::Key_Q);
+	quitAction->setShortcut(Qt::CTRL | Qt::Key_Q);
 	connect(quitAction, &QAction::triggered,
 		this, &ConfigMainWindow::close);
 
 	QAction *loadAction = new QAction(QPixmap(xpm_load), "&Load", this);
-	loadAction->setShortcut(Qt::CTRL + Qt::Key_L);
+	loadAction->setShortcut(Qt::CTRL | Qt::Key_L);
 	connect(loadAction, &QAction::triggered,
 		this, &ConfigMainWindow::loadConfig);
 
 	saveAction = new QAction(QPixmap(xpm_save), "&Save", this);
-	saveAction->setShortcut(Qt::CTRL + Qt::Key_S);
+	saveAction->setShortcut(Qt::CTRL | Qt::Key_S);
 	connect(saveAction, &QAction::triggered,
 		this, &ConfigMainWindow::saveConfig);
 
@@ -1403,7 +1405,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 	connect(saveAsAction, &QAction::triggered,
 		this, &ConfigMainWindow::saveConfigAs);
 	QAction *searchAction = new QAction("&Find", this);
-	searchAction->setShortcut(Qt::CTRL + Qt::Key_F);
+	searchAction->setShortcut(Qt::CTRL | Qt::Key_F);
 	connect(searchAction, &QAction::triggered,
 		this, &ConfigMainWindow::searchConfig);
 	singleViewAction = new QAction(QPixmap(xpm_single_view), "Single View", this);
@@ -1750,11 +1752,21 @@ void ConfigMainWindow::closeEvent(QCloseEvent* e)
 		e->accept();
 		return;
 	}
-	QMessageBox mb("qconf", "Save configuration?", QMessageBox::Warning,
-			QMessageBox::Yes | QMessageBox::Default, QMessageBox::No, QMessageBox::Cancel | QMessageBox::Escape);
-	mb.setButtonText(QMessageBox::Yes, "&Save Changes");
-	mb.setButtonText(QMessageBox::No, "&Discard Changes");
-	mb.setButtonText(QMessageBox::Cancel, "Cancel Exit");
+
+	QMessageBox mb(QMessageBox::Icon::Warning, "qconf",
+		       "Save configuration?");
+
+	QPushButton *yb = mb.addButton(QMessageBox::Yes);
+	QPushButton *db = mb.addButton(QMessageBox::No);
+	QPushButton *cb = mb.addButton(QMessageBox::Cancel);
+
+	yb->setText("&Save Changes");
+	db->setText("&Discard Changes");
+	cb->setText("Cancel Exit");
+
+	mb.setDefaultButton(yb);
+	mb.setEscapeButton(cb);
+
 	switch (mb.exec()) {
 	case QMessageBox::Yes:
 		if (saveConfig())
-- 
2.40.1

